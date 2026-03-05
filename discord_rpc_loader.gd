extends Node

var _discord_rpc_available: bool = false

func _ready() -> void:
	_discord_rpc_available = (not OS.has_feature("web") and ClassDB.class_exists("DiscordRPC"))
	if not _discord_rpc_available:
		set_process(false)

func _process(_delta) -> void:
	if _discord_rpc_available:
		DiscordRPC.run_callbacks()
