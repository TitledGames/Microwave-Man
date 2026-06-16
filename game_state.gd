extends Node

# Emitted from coin.gd and handled in level.gd (used across scripts).
@warning_ignore("unused_signal")
signal coin_collected

const MAX_LIVES = 3
const LEVELS = [
	"res://main.tscn",
	"res://level_2.tscn",
	"res://level_3.tscn",
]
const HIGHSCORE_PATH = "user://highscores.json"
const MAX_HIGHSCORES = 10

var lives = MAX_LIVES
var current_level = 0
var coins = 0
var total_coins = 0
var elapsed_time = 0.0
var is_level_running = false
var won = false

func start_new_game() -> void:
	lives = MAX_LIVES
	current_level = 0
	coins = 0
	total_coins = 0
	elapsed_time = 0.0
	is_level_running = false
	won = false

func lose_life() -> int:
	lives = max(lives - 1, 0)
	return lives

func advance_level() -> void:
	current_level += 1
	if current_level < LEVELS.size():
		get_tree().change_scene_to_file(LEVELS[current_level])
	else:
		won = true
		is_level_running = false
		get_tree().change_scene_to_file("res://endcreen.tscn")

func game_over() -> void:
	won = false
	is_level_running = false
	get_tree().change_scene_to_file("res://endcreen.tscn")

func format_time(seconds: float) -> String:
	var total_seconds: int = int(seconds)
	@warning_ignore("integer_division")
	var mins: int = total_seconds / 60
	var secs: int = total_seconds % 60
	return "%02d:%02d" % [mins, secs]

func get_highscores() -> Array:
	if not FileAccess.file_exists(HIGHSCORE_PATH):
		return []
	var file = FileAccess.open(HIGHSCORE_PATH, FileAccess.READ)
	if file == null:
		return []
	var data = JSON.parse_string(file.get_as_text())
	file.close()
	if not data is Array:
		return []
	var valid: Array = []
	for entry in data:
		if entry is Dictionary \
				and entry.has("name") and entry["name"] is String \
				and entry.has("time") and (entry["time"] is float or entry["time"] is int) \
				and entry.has("coins") and (entry["coins"] is float or entry["coins"] is int):
			valid.append({
				"name": entry["name"],
				"time": float(entry["time"]),
				"coins": int(entry["coins"])
			})
	return valid

func save_highscore(player_name: String) -> void:
	player_name = player_name.strip_edges()
	if player_name.is_empty():
		player_name = "Anonymous"
	var scores = get_highscores()
	scores.append({
		"name": player_name,
		"time": elapsed_time,
		"coins": coins
	})
	# Best score is the most coins; ties broken by the faster time.
	scores.sort_custom(func(a, b):
		if a["coins"] == b["coins"]:
			return a["time"] < b["time"]
		return a["coins"] > b["coins"])
	if scores.size() > MAX_HIGHSCORES:
		scores.resize(MAX_HIGHSCORES)
	var file = FileAccess.open(HIGHSCORE_PATH, FileAccess.WRITE)
	if file == null:
		return
	file.store_string(JSON.stringify(scores))
	file.close()
