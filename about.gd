extends Node2D

func _ready() -> void:
	var version = ProjectSettings.get_setting("application/config/version", "")
	if version != "":
		$BuildLabel.text = version


func _on_button_pressed() -> void:
	var err = get_tree().change_scene_to_file("res://main_menu.tscn")
	if err != OK:
		push_error("Failed to load main_menu.tscn (error code: %s)" % err)

