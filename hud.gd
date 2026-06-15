extends CanvasLayer

@onready var life_icons = $Lives.get_children()

func update_lives(lives):
	for i in life_icons.size():
		life_icons[i].visible = i < lives

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()


func _on_message_timer_timeout() -> void:
	$Message.hide()
