extends Node

var _discord_rpc_available: bool = false

func _ready() -> void:
	_discord_rpc_available = Engine.has_singleton("DiscordRPC")
	if not _discord_rpc_available:
		set_process(false)

func _process(_delta) -> void:
	if _discord_rpc_available:
		var discord_rpc = Engine.get_singleton("DiscordRPC")
		if discord_rpc:
			discord_rpc.call("run_callbacks")
