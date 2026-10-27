extends CanvasLayer

@onready var life_icons = $Lives.get_children()

func update_lives(lives):
	for i in life_icons.size():
		life_icons[i].visible = i < lives

func update_coins(coins):
	$CoinLabel.text = "Coins: " + str(coins)

func update_timer(seconds):
	$TimerLabel.text = GameState.format_time(seconds)

func play_hit():
	$HitSound.play()

func play_game_over():
	$GameOverSound.play()
