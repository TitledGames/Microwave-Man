extends Area2D

signal hit

@export var speed = 400 # player speed
var screen_size # windows size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	screen_size = get_viewport_rect().size
	
	hide()
	
	pass # function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var velocity = Vector2.ZERO 
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	pass


func _on_body_entered(body: Node2D) -> void:
	
	hide() # Player is hidden
	hit.emit()
	
	$PlayerHitbox.set_deferred("disabled", true)
	
	pass # Replace with function body.

func start(pos):
	position = pos
	show()
	$PlayerHitbox.disabled = false
	
