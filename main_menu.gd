extends Node2D

func _ready() -> void:
	if not OS.has_feature("web"):
		var discord = get_node_or_null("/root/DiscordRPC")
		
		if discord != null:
			discord.app_id = 1465471267183263922
			discord.details = "Play as a microwave!"
			discord.state = "Playing the game!"
			discord.large_image = "ground"
			discord.large_image_text = "Play now!"
			discord.small_image = "level"
			discord.small_image_text = "Playing Microwave-Man!"
			discord.start_timestamp = int(Time.get_unix_time_from_system())
			discord.refresh()

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_playgame_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")

func _on_extras_pressed() -> void:
	get_tree().change_scene_to_file("res://about.tscn")