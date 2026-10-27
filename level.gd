extends Node

# Indexed by GameState.current_level: level 4 (the grassy finale) loops back to
# the overworld theme. clampi keeps any extra levels on the last track.
const AREA_TRACKS = ["overworld", "sky", "castle", "overworld"]

@onready var player = $Player
@onready var hud = $HUD

var spawn_point = Vector2.ZERO
var fall_limit = 0.0

func _ready() -> void:
	Music.play(AREA_TRACKS[clampi(GameState.current_level, 0, AREA_TRACKS.size() - 1)])
	spawn_point = player.position
	# Falling well below the start (e.g. off a sky platform) costs a life.
	fall_limit = spawn_point.y + 360.0
	player.hit.connect(_on_player_hit)
	GameState.coin_collected.connect(_on_coin_collected)
	# Children are ready before the parent, so every coin is already in the
	# group by now.
	GameState.total_coins += get_tree().get_nodes_in_group("coins").size()
	GameState.is_level_running = true
	hud.update_lives(GameState.lives)
	hud.update_coins(GameState.coins)
	hud.update_timer(GameState.elapsed_time)
	_update_discord_presence()

func _process(delta: float) -> void:
	if GameState.is_level_running:
		var prev_second = int(GameState.elapsed_time)
		GameState.elapsed_time += delta
		if int(GameState.elapsed_time) != prev_second:
			hud.update_timer(GameState.elapsed_time)
		if not player.invincible and player.position.y > fall_limit:
			player.take_hit()

func _on_coin_collected() -> void:
	hud.update_coins(GameState.coins)
	_update_discord_presence()

func _update_discord_presence() -> void:
	if not OS.has_feature("web") and Engine.has_singleton("DiscordRPC"):
		var discord_rpc = Engine.get_singleton("DiscordRPC")
		discord_rpc.set("state", "In Game")
		discord_rpc.set("details", "Collecting coins!")
		discord_rpc.set("large_image", "ground")
		discord_rpc.set("large_image_text", "Play now!")
		discord_rpc.set("small_image", "coin")
		discord_rpc.set("small_image_text", "Coins collected: " + str(GameState.coins))
		discord_rpc.call("refresh")

func _on_player_hit() -> void:
	var remaining = GameState.lose_life()
	hud.update_lives(remaining)
	_reset_enemies()
	if remaining > 0:
		hud.play_hit()
		player.respawn(spawn_point)
	else:
		_game_over()

func _reset_enemies() -> void:
	for enemy in get_tree().get_nodes_in_group("enemies"):
		if enemy.has_method("reset"):
			enemy.reset()

func _game_over() -> void:
	GameState.is_level_running = false
	player.hide_player()
	hud.play_game_over()
	await get_tree().create_timer(1.6).timeout
	GameState.game_over()
