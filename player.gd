extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -350.0
const GRAVITY = 980

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var is_playing_special = false

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
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

	if direction > 0:
		sprite.flip_h = false 
	elif direction < 0:
		sprite.flip_h = true
		
	if not is_playing_special:
		if velocity.length() > 0:
			$AnimatedSprite2D.play("default")
		else:
			$AnimatedSprite2D.stop()

func play_collect_animation():
	is_playing_special = true
	sprite.play("coin")

func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "coin":
		is_playing_special = false
		
		if velocity.length() > 0:
			sprite.play("default")
		else:
			sprite.play("default") 
			sprite.stop() 
		
func start(pos):
	position = pos
	show()
	$PlayerHitbox.disabled = false

func hide_player():
	hide()
	$PlayerHitbox.disabled = true
