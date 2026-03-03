extends Node

func _process(_delta) -> void:
	if not OS.has_feature("web") and ClassDB.class_exists("DiscordRPC"):
		DiscordRPC.run_callbacks()
