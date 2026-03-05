extends Node

func _ready():
	GameState.restart_game.connect(new_game)
	GameState.coin_collected.connect(_on_coin_collected)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func game_over() -> void:
	$ScoreTimer.stop()
	$HUD.show_game_over()

func new_game():
	GameState.coins = 0
	
	var player = get_node("Player")
	if player:
		player.start(Vector2(-589, 471.99997))

	$StartTimer.start()
	$HUD.update_coins(0)

func _on_coin_collected() -> void:
	$HUD.update_coins(GameState.coins)
