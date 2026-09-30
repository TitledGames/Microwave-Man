extends Area2D

# Lava, spikes, etc. Costs the player a life on contact.
func _on_body_entered(body):
	if body.is_in_group("player") and body.has_method("take_hit"):
		body.take_hit()

# Entry alone misses a player who is still touching the hazard when invincibility ends.
func _physics_process(_delta: float) -> void:
	for body in get_overlapping_bodies():
		_on_body_entered(body)
