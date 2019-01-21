extends Node

export (PackedScene) var Coin
export (PackedScene) var Power_up
export (int) var playtime

var level
var score
var time_left
var screensize
var playing = false


func _ready():
	# random seed of the random generator
	randomize()
	screensize = get_viewport().get_visible_rect().size
	$Player.screensize = screensize
	$Player.hide()


func new_game():
	playing = true
	level = 1
	score = 0
	time_left = playtime
	$Player.start($PlayerStart.position)
	$Player.show()
	$GameTimer.start()
	spawn_coins()
	$HUD.update_score(score)
	$HUD.update_timer(time_left)


func spawn_coins():
	$LevelSound.play()
	for i in range(4 +  level):
		var c = Coin.instance()
		$CoinContainer.add_child(c)
		c.screensize = screensize
		c.position = Vector2(rand_range(0, screensize.x),
							 rand_range(0, screensize.y))


func _process(delta):
	if playing and $CoinContainer.get_child_count() == 0:
		level += 1
		time_left += 5
		spawn_coins()
		$PowerUpTimer.wait_time = rand_range(5, 10)
		$PowerUpTimer.start()


func _on_GameTimer_timeout():
	time_left -= 1
	$HUD.update_timer(time_left)
	if time_left <= 0:
		game_over()


func _on_Player_pickup(type):
	match type:
		"coin":
			$CoinSound.play()
			score += 1
			$HUD.update_score(score)
		"powerup":
			time_left += 5
			$PowerUpSound.play()
			$HUD.update_timer(time_left)


func _on_Player_hurt():
	game_over()


func game_over():
	$EndSound.play()
	playing = false
	$GameTimer.stop()
	for coin in $CoinContainer.get_children():
		coin.queue_free()
	$HUD.show_game_over()
	$Player.die()
	$PowerUpTimer.stop()


func _on_PowerUpTimer_timeout():
	var power_up = Power_up.instance()
	add_child(power_up)
	power_up.screensize = screensize
	power_up.position = Vector2(rand_range(0, screensize.x),
								rand_range(0, screensize.y))
