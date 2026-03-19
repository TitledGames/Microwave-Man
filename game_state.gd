extends Node

signal restart_game
signal coin_collected

var coins: int = 0
var total_coins: int = 0
var elapsed_time: float = 0.0
var is_level_running: bool = false

const HIGHSCORE_PATH = "user://highscores.json"
const MAX_HIGHSCORES = 10

func format_time(seconds: float) -> String:
	var total_seconds: int = int(seconds)
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
	var scores = get_highscores()
	scores.append({
		"name": player_name,
		"time": elapsed_time,
		"coins": coins
	})
	scores.sort_custom(func(a, b): return a["time"] < b["time"])
	if scores.size() > MAX_HIGHSCORES:
		scores.resize(MAX_HIGHSCORES)
	var file = FileAccess.open(HIGHSCORE_PATH, FileAccess.WRITE)
	if file == null:
		return
	file.store_string(JSON.stringify(scores))
	file.close()
