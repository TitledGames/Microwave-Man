extends Node

func _ready() -> void:
	# The coin that spawned this is freed right away, so clean ourselves up
	# once the sound has finished instead of lingering in the scene.
	$AudioStreamPlayer.finished.connect(queue_free)
