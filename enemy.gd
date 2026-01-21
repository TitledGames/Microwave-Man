extends RigidBody2D

@export var speed = 200
var velocity = Vector2(1, 0)

func _physics_process(delta):
	linear_velocity = velocity * speed

func _on_body_entered(body):
	if body.is_in_group("walls"):
		velocity.x *= -1
	if body.is_in_group("player"):
		get_tree().root.get_node("Main").game_over()
