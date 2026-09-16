extends Node

const TRACKS = {
	"overworld": preload("res://assets/sounds/music_overworld.ogg"),
	"sky": preload("res://assets/sounds/music_sky.ogg"),
	"castle": preload("res://assets/sounds/music_castle.ogg"),
}

var _player: AudioStreamPlayer
var _current = ""

func _ready() -> void:
	_player = AudioStreamPlayer.new()
	_player.volume_db = -12.0
	add_child(_player)
	for stream in TRACKS.values():
		stream.loop = true

func play(track: String) -> void:
	# Switch tracks only when the area actually changes, so the music keeps
	# looping smoothly across scene changes within the same area.
	if track == _current or not TRACKS.has(track):
		return
	_current = track
	_player.stream = TRACKS[track]
	_player.play()
