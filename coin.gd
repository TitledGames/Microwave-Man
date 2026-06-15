extends Area2D

const COIN_SOUND_SCENE = preload("res://coin_sfx.tscn")

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	_animate()

func _animate() -> void:
	# Reuse the single coin sprite, but fake a spin by squashing it
	# horizontally, and add a gentle bob so the coins feel alive.
	var base_y = sprite.position.y

	var spin = create_tween().set_loops()
	spin.tween_property(sprite, "scale:x", 0.15, 0.45).set_trans(Tween.TRANS_SINE)
	spin.tween_property(sprite, "scale:x", 1.0, 0.45).set_trans(Tween.TRANS_SINE)

	var bob = create_tween().set_loops()
	bob.tween_property(sprite, "position:y", base_y - 4.0, 0.9).set_trans(Tween.TRANS_SINE)
	bob.tween_property(sprite, "position:y", base_y, 0.9).set_trans(Tween.TRANS_SINE)


func _on_body_entered(body):
	# Check if the body overlapping the coin is actually the player
	if body.is_in_group("player"):

		if body.has_method("play_collect_animation"):
			body.play_collect_animation()

		var sound_instance = COIN_SOUND_SCENE.instantiate()

		# Add it to the main tree (it starts playing immediately due to Autoplay)
		get_tree().current_scene.add_child(sound_instance)

		# This deletes the coin from the world
		queue_free()
