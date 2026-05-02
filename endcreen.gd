extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CoinCount.text = "Coins collected: " + str(GameState.coins) + " / " + str(GameState.total_coins)
	$TimeLabel.text = "Time: " + GameState.format_time(GameState.elapsed_time)
	_refresh_highscores()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _refresh_highscores() -> void:
	var scores = GameState.get_highscores()
	if scores.is_empty():
		$HighScoresList.text = "No scores yet!"
		return
	var text = ""
	for i in range(scores.size()):
		var s = scores[i]
		text += "%d. %s  %s  (%d coins)\n" % [i + 1, s["name"], GameState.format_time(s["time"]), s["coins"]]
	$HighScoresList.text = text.strip_edges()


func _on_save_score_pressed() -> void:
	var player_name = $NameInput.text.strip_edges()
	if player_name.is_empty():
		player_name = "Anonymous"
	GameState.save_highscore(player_name)
	$NameInput.text = ""
	$SaveScoreButton.disabled = true
	_refresh_highscores()


func _on_play_again_pressed() -> void:
	GameState.restart_game.emit()
	get_tree().change_scene_to_file("res://main.tscn")

func _on_back_to_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
