extends AnimatableBody2D

# Oscillates between start and start + travel; carries the player who stands
# on it (sync_to_physics handles that).
@export var travel = Vector2(96, 0)
@export var speed = 1.4

var _start = Vector2.ZERO
var _time = 0.0

func _ready() -> void:
	_start = position

func _physics_process(delta: float) -> void:
	_time += delta
	position = _start + travel * sin(_time * speed)
