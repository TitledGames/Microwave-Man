extends CharacterBody2D

const SPEED = 60.0
const GRAVITY = 980.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ledge_check: RayCast2D = $LedgeCheck
@onready var hitbox_shape: CollisionShape2D = $Hitbox/CollisionShape2D

var start_position = Vector2.ZERO
var direction = -1
var defeated = false

func _ready() -> void:
	start_position = position
	# Patrol the world but never shove the player around.
	var player = get_tree().get_first_node_in_group("player")
	if player:
		add_collision_exception_with(player)
	sprite.play("walk")

func _physics_process(delta: float) -> void:
	if defeated:
		return

	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Turn around at a wall or before walking off a ledge.
	if is_on_floor() and (is_on_wall() or not ledge_check.is_colliding()):
		_turn()

	velocity.x = direction * SPEED
	move_and_slide()

func _turn() -> void:
	direction = -direction
	sprite.flip_h = direction > 0
	ledge_check.position.x = absf(ledge_check.position.x) * direction

func _on_hitbox_body_entered(body):
	if defeated or not body.is_in_group("player"):
		return

	# A stomp: the player is dropping down onto our head.
	if body.velocity.y > 0 and body.global_position.y < global_position.y:
		_defeat()
		if body.has_method("bounce"):
			body.bounce()
	elif body.has_method("take_hit"):
		body.take_hit()

func _defeat() -> void:
	defeated = true
	hitbox_shape.set_deferred("disabled", true)
	velocity = Vector2.ZERO
	var tween = create_tween()
	tween.tween_property(sprite, "scale:y", 0.1, 0.12)
	tween.parallel().tween_property(sprite, "modulate:a", 0.0, 0.18)
	tween.tween_callback(hide)

func reset() -> void:
	# Put the enemy back where it started when the player respawns.
	position = start_position
	direction = -1
	defeated = false
	velocity = Vector2.ZERO
	sprite.scale = Vector2.ONE
	sprite.modulate.a = 1.0
	sprite.flip_h = false
	ledge_check.position.x = -absf(ledge_check.position.x)
	hitbox_shape.set_deferred("disabled", false)
	show()
	sprite.play("walk")
