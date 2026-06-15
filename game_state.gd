extends Node

signal restart_game

const MAX_LIVES = 3
const LEVELS = [
	"res://main.tscn",
]

var lives = MAX_LIVES
var current_level = 0

func start_new_game() -> void:
	lives = MAX_LIVES
	current_level = 0

func lose_life() -> int:
	lives = max(lives - 1, 0)
	return lives

func advance_level() -> void:
	current_level += 1
	if current_level < LEVELS.size():
		get_tree().change_scene_to_file(LEVELS[current_level])
	else:
		current_level = 0
		get_tree().change_scene_to_file("res://endcreen.tscn")
