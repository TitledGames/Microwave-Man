extends Node

@onready var player = $Player
@onready var hud = $HUD

var spawn_point = Vector2.ZERO

func _ready() -> void:
	spawn_point = player.position
	player.hit.connect(_on_player_hit)
	hud.update_lives(GameState.lives)
	hud.show_message("Get Ready")

func _on_player_hit() -> void:
	var remaining = GameState.lose_life()
	hud.update_lives(remaining)
	if remaining > 0:
		player.respawn(spawn_point)
		hud.show_message("Get Ready")
	else:
		_game_over()

func _game_over() -> void:
	player.hide_player()
	hud.show_message("Game Over")
	await get_tree().create_timer(2.0).timeout
	GameState.start_new_game()
	get_tree().change_scene_to_file("res://main_menu.tscn")
