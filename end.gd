extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameState.is_level_running = false
		var err = get_tree().change_scene_to_file("res://endcreen.tscn")
		if err != OK:
			push_error("Failed to load endcreen.tscn (error code: %s)" % err)
