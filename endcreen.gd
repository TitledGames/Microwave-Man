extends Node2D

func _ready() -> void:
	var version = ProjectSettings.get_setting("application/config/version", "")
	if version != "":
		$BuildLabel.text = version
	Music.play("overworld")
	$Title.text = "You Win!!!" if GameState.won else "Game Over"
	$CoinCount.text = "Coins collected: %d / %d" % [GameState.coins, GameState.total_coins]
	$TimeLabel.text = "Time: " + GameState.format_time(GameState.elapsed_time)
	_refresh_highscores()


func _refresh_highscores() -> void:
	var scores = GameState.get_highscores()
	if scores.is_empty():
		$HighScoresList.text = "No scores yet!"
		return
	var text = ""
	for i in range(scores.size()):
		var s = scores[i]
		text += "%d. %s  %d coins  %s\n" % [i + 1, s["name"], s["coins"], GameState.format_time(s["time"])]
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
	GameState.start_new_game()
	get_tree().change_scene_to_file(GameState.LEVELS[0])

func _on_back_to_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
