extends Area2D

const COIN_SOUND_SCENE = preload("res://coin_sfx.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("coins")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body):
	# Check if the body overlapping the coin is actually the player
	if body.is_in_group("player"):
		
		if body.has_method("play_collect_animation"):
			body.play_collect_animation()
		
		var sound_instance = COIN_SOUND_SCENE.instantiate()
		
		# Add it to the main tree (it starts playing immediately due to Autoplay)
		get_tree().current_scene.add_child(sound_instance)
		
		# Track the collected coin in the global game state
		GameState.coins += 1
		GameState.coin_collected.emit()
		
		# This deletes the coin from the world
		queue_free()
