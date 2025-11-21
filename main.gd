extends Node

var score



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func game_over() -> void:
	$ScoreTimer.stop()
	$HUD.show_game_over()
	pass # Replace with function body.

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")



func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)
	pass # Replace with function body.


func _on_start_timer_timeout() -> void:
	$ScoreTimer.start()
	
	pass # Replace with function body.
