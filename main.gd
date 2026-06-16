extends Node

const SPAWN_POSITION = Vector2(-589, 471.99997)
const DISCORD_STATE_KEY = "state"
const DISCORD_DETAILS_KEY = "details"
const DISCORD_LARGE_IMAGE_KEY = "large_image"
const DISCORD_LARGE_IMAGE_TEXT_KEY = "large_image_text"
const DISCORD_SMALL_IMAGE_KEY = "small_image"
const DISCORD_SMALL_IMAGE_TEXT_KEY = "small_image_text"

func _ready():
	GameState.restart_game.connect(new_game)
	GameState.coin_collected.connect(_on_coin_collected)
	# In Godot 4, children's _ready() runs before the parent's, so all coins
	# have already added themselves to the "coins" group by this point.
	GameState.total_coins = get_tree().get_nodes_in_group("coins").size()
	GameState.coins = 0
	GameState.elapsed_time = 0.0
	GameState.is_level_running = false
	$HUD.update_coins(0)
	$HUD.update_timer(0.0)
	$StartTimer.start()

func _process(delta: float) -> void:
	if GameState.is_level_running:
		var prev_second = int(GameState.elapsed_time)
		GameState.elapsed_time += delta
		var current_second = int(GameState.elapsed_time)
		if current_second != prev_second:
			$HUD.update_timer(GameState.elapsed_time)

func new_game():
	GameState.coins = 0
	GameState.elapsed_time = 0.0
	GameState.is_level_running = false

	var player = get_node("Player")
	if player:
		player.start(SPAWN_POSITION)

	$HUD.update_coins(0)
	$HUD.update_timer(0.0)
	$StartTimer.start()

func _on_start_timer_timeout() -> void:
	GameState.is_level_running = true
	_update_discord_state()

func _update_discord_state() -> void:
	if not OS.has_feature("web") and Engine.has_singleton("DiscordRPC"):
		var discord_rpc = Engine.get_singleton("DiscordRPC")
		discord_rpc.set(DISCORD_STATE_KEY, "In Game")
		discord_rpc.set(DISCORD_DETAILS_KEY, "Collecting coins!")
		discord_rpc.set(DISCORD_LARGE_IMAGE_KEY, "ground")
		discord_rpc.set(DISCORD_LARGE_IMAGE_TEXT_KEY, "Play now!")
		discord_rpc.set(DISCORD_SMALL_IMAGE_KEY, "coin")
		discord_rpc.set(DISCORD_SMALL_IMAGE_TEXT_KEY, "Coins collected: " + str(GameState.coins))
		discord_rpc.call("refresh")

func _on_coin_collected() -> void:
	$HUD.update_coins(GameState.coins)
	_update_discord_state()
