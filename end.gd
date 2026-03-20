extends Area2D

func _on_body_entered(body):
	# Check if the body overlapping the level end trigger is actually the player
	if body.is_in_group("player"):
		GameState.is_level_running = false
		get_tree().change_scene_to_file("res://endcreen.tscn")
