extends Node2D

func _ready() -> void:
	var version = ProjectSettings.get_setting("application/config/version", "")
	if version != "":
		$BuildLabel.text = version

	if not OS.has_feature("web") and Engine.has_singleton("DiscordRPC"):
		var discord_rpc = Engine.get_singleton("DiscordRPC")
		discord_rpc.set("app_id", 1465471267183263922)
		discord_rpc.set("details", "Play as a microwave!")
		discord_rpc.set("state", "Playing the game!")
		discord_rpc.set("large_image", "ground")
		discord_rpc.set("large_image_text", "Play now!")
		discord_rpc.set("small_image", "level")
		discord_rpc.set("small_image_text", "Playing Microwave-Man!")
		discord_rpc.set("start_timestamp", int(Time.get_unix_time_from_system()))
		discord_rpc.call("refresh")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_playgame_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")

func _on_extras_pressed() -> void:
	get_tree().change_scene_to_file("res://about.tscn")
