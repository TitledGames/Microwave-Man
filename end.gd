extends Area2D

func _ready() -> void:
	_sway()

func _sway() -> void:
	# Let the flag wave gently in the wind.
	var tween = create_tween().set_loops()
	tween.tween_property($Flag, "rotation", 0.04, 1.0).set_trans(Tween.TRANS_SINE)
	tween.tween_property($Flag, "rotation", -0.04, 1.0).set_trans(Tween.TRANS_SINE)

func _on_body_entered(body):
	# Check if the body reaching the goal is actually the player
	if body.is_in_group("player"):
		GameState.advance_level()
