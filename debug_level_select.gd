extends Node

# Debug build only: press 1-4 to jump straight into main/level_2/level_3/level_4
# with a fresh game state, skipping the menu.

func _unhandled_input(event: InputEvent) -> void:
	if not OS.is_debug_build():
		return
	if not (event is InputEventKey and event.pressed and not event.echo):
		return
	var idx = event.keycode - KEY_1
	if idx < 0 or idx >= GameState.LEVELS.size():
		return
	GameState.start_new_game()
	GameState.current_level = idx
	get_tree().change_scene_to_file(GameState.LEVELS[idx])
