extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -350.0
const GRAVITY = 980

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta 

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY  
		audio_player.play()
		velocity.y = JUMP_VELOCITY 

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func start(pos):
	position = pos
	show()
	$PlayerHitbox.disabled = false

func hide_player():
	hide()
	$PlayerHitbox.disabled = true
	
