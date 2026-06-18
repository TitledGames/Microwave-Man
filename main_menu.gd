extends Node2D

const DISCORD_APP_ID = 1465471267183263922

func _ready() -> void:
	var version = ProjectSettings.get_setting("application/config/version", "")
	if version != "":
		$BuildLabel.text = version

	if not OS.has_feature("web") and Engine.has_singleton("DiscordRPC"):
		var discord_rpc = Engine.get_singleton("DiscordRPC")
		discord_rpc.set("app_id", DISCORD_APP_ID)
		discord_rpc.set("details", "Play as a microwave!")
		discord_rpc.set("state", "In Main Menu")
		discord_rpc.set("large_image", "ground")
		discord_rpc.set("large_image_text", "Play now!")
		discord_rpc.set("small_image", "level")
		discord_rpc.set("small_image_text", "Playing Microwave-Man!")
		discord_rpc.set("start_timestamp", int(Time.get_unix_time_from_system()))
		discord_rpc.call("refresh")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_playgame_pressed() -> void:
	var err = get_tree().change_scene_to_file("res://main.tscn")
	if err != OK:
		push_error("Failed to change scene to res://main.tscn (error code: %s)" % err)

func _on_about_pressed() -> void:
	var err = get_tree().change_scene_to_file("res://about.tscn")
	if err != OK:
		push_error("Failed to change scene to res://about.tscn (error code: %s)" % err)
