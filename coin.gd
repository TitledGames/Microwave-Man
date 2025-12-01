extends Area2D

const COIN_SOUND_SCENE = preload("res://coin_sfx.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body):
	# Check if the body overlapping the coin is actually the player
	if body.is_in_group("player"):
		
		var sound_instance = COIN_SOUND_SCENE.instantiate()
		
		# Add it to the main tree (it starts playing immediately due to Autoplay)
		get_tree().current_scene.add_child(sound_instance)
		
		# This deletes the coin from the world
		queue_free()
		
