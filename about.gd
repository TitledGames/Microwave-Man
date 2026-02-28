extends Node2D


func _ready() -> void:
	var version = ProjectSettings.get_setting("application/config/version", "")
	if version != "":
		$BuildLabel.text = "v" + version


func _on_button_pressed() -> void:
	pass # Replace with function body.
	get_tree().change_scene_to_file("res://main_menu.tscn")
