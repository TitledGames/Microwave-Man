extends Node2D

func _ready() -> void:
	var version = ProjectSettings.get_setting("application/config/version", "")
	if version != "":
		$BuildLabel.text = version

	_animate_menu()

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

func _animate_menu() -> void:
	# Spin the coins and bob the title so the menu feels alive.
	for coin in [$Coin, $Coin2]:
		var full_x = coin.scale.x
		var spin = create_tween().set_loops()
		spin.tween_property(coin, "scale:x", full_x * 0.15, 0.45).set_trans(Tween.TRANS_SINE)
		spin.tween_property(coin, "scale:x", full_x, 0.45).set_trans(Tween.TRANS_SINE)

	var base_y = $title.position.y
	var bob = create_tween().set_loops()
	bob.tween_property($title, "position:y", base_y - 8.0, 1.2).set_trans(Tween.TRANS_SINE)
	bob.tween_property($title, "position:y", base_y, 1.2).set_trans(Tween.TRANS_SINE)

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_playgame_pressed() -> void:
	GameState.start_new_game()
	get_tree().change_scene_to_file(GameState.LEVELS[0])

func _on_extras_pressed() -> void:
	get_tree().change_scene_to_file("res://about.tscn")