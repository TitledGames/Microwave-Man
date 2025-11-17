extends Node

@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func game_over() -> void:
	
	$ScoreTimer.stop()
	$MobTimer.stop()
	pass # Replace with function body.

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	


func _on_mob_timer_timeout() -> void:
	pass # Replace with function body.


func _on_score_timer_timeout() -> void:
	score += 1
	pass # Replace with function body.


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
	
	pass # Replace with function body.
