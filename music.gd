extends Node

const MUSIC = preload("res://assets/sounds/music.ogg")

var _player: AudioStreamPlayer

func _ready() -> void:
	_player = AudioStreamPlayer.new()
	_player.stream = MUSIC
	_player.stream.loop = true
	_player.volume_db = -12.0
	add_child(_player)
	_player.play()
