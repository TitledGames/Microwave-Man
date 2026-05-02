extends Node

const SPAWN_POSITION = Vector2(-589, 471.99997)

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
		if int(GameState.elapsed_time) != prev_second:
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

func _on_coin_collected() -> void:
	$HUD.update_coins(GameState.coins)
