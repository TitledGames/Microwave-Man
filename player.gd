extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -350.0
const GRAVITY = 980
const DECELERATION = 1200.0

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player_hitbox: CollisionShape2D = $PlayerHitbox

var is_playing_special = false

func _ready() -> void:
	var animation_finished_handler := Callable(self, "_on_animated_sprite_2d_animation_finished")
	if not sprite.animation_finished.is_connected(animation_finished_handler):
		sprite.animation_finished.connect(animation_finished_handler)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		audio_player.play()

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION * delta)
	
	move_and_slide()

	if direction > 0:
		if sprite.flip_h:
			sprite.flip_h = false
	elif direction < 0:
		if not sprite.flip_h:
			sprite.flip_h = true
		
	if not is_playing_special:
		update_animation()

func update_animation() -> void:
	if velocity.x != 0:
		sprite.play("default")
	else:
		sprite.stop()

func play_collect_animation() -> void:
	is_playing_special = true
	sprite.play("coin")

func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "coin":
		is_playing_special = false
		update_animation()
		
func start(pos: Vector2) -> void:
	position = pos
	show()
	player_hitbox.set_deferred("disabled", false)

func disable_player() -> void:
	hide()
	player_hitbox.set_deferred("disabled", true)
