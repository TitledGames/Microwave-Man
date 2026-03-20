extends CanvasLayer

signal start_game

func update_coins(coins: int) -> void:
	$CoinLabel.text = "Coins: " + str(coins)

func update_timer(seconds: float) -> void:
	$TimerLabel.text = GameState.format_time(seconds)

func _on_start_button_pressed() -> void:
	$StartButton.hide()
	start_game.emit()
