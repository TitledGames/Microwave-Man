extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DiscordRPC.app_id = 1465471267183263922
	DiscordRPC.details = "Play as a microwave!"
	DiscordRPC.state = "Playing the game!"
	DiscordRPC.large_image = "ground"
	DiscordRPC.large_image_text = "Play now!"
	DiscordRPC.small_image = "level"
	DiscordRPC.small_image_text = "Playing Microwave-Man!"

	DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system())

	DiscordRPC.refresh()

func _on_quit_pressed() -> void:
	pass # Replace with function body.
	get_tree().quit()

func _on_playgame_pressed() -> void:
	pass # Replace with function body.
	get_tree().change_scene_to_file("res://main.tscn")

func _on_extras_pressed() -> void:
	pass # Replace with function body.
	get_tree().change_scene_to_file("res://about.tscn")
