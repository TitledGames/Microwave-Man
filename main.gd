extends Node

var score

func _ready():
	GameState.restart_game.connect(new_game)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func game_over() -> void:
	$ScoreTimer.stop()
	$HUD.show_game_over()

func new_game():
	score = 0
	
	var player = get_node("Player")
	if player:
		player.start(Vector2(-589, 471.99997))

	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")



func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout() -> void:
	$ScoreTimer.start()
	