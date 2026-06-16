extends Node

const AREA_TRACKS = ["overworld", "sky", "castle"]

@onready var player = $Player
@onready var hud = $HUD

var spawn_point = Vector2.ZERO

func _ready() -> void:
	Music.play(AREA_TRACKS[clampi(GameState.current_level, 0, AREA_TRACKS.size() - 1)])
	spawn_point = player.position
	player.hit.connect(_on_player_hit)
	GameState.coin_collected.connect(_on_coin_collected)
	# Children are ready before the parent, so every coin is already in the
	# group by now.
	GameState.total_coins += get_tree().get_nodes_in_group("coins").size()
	GameState.is_level_running = true
	hud.update_lives(GameState.lives)
	hud.update_coins(GameState.coins)
	hud.update_timer(GameState.elapsed_time)

func _process(delta: float) -> void:
	if GameState.is_level_running:
		var prev_second = int(GameState.elapsed_time)
		GameState.elapsed_time += delta
		if int(GameState.elapsed_time) != prev_second:
			hud.update_timer(GameState.elapsed_time)

func _on_coin_collected() -> void:
	hud.update_coins(GameState.coins)

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
