extends Area2D


var screensize = Vector2()


func _ready():
	$Tween.interpolate_property($AnimatedSprite, # node to afect
								'scale', # property to alter
								$AnimatedSprite.scale, # property starting value
								$AnimatedSprite.scale * 3, # property ending value
								0.3, # duration (seconds)
								Tween.TRANS_QUAD, #the function to use
								Tween.EASE_IN_OUT) #the direction

	$Tween.interpolate_property($AnimatedSprite,
								'modulate',
								Color(1,1,1,1),
								Color(1,1,1,0),
								0.3,
								Tween.TRANS_QUAD,
								Tween.EASE_IN_OUT)

	$Timer.wait_time = rand_range(2, 5)
	$Timer.start()

func pickup():
	monitoring = false # monitoring disables the ara enter and exit signals from Area2D
	$Tween.start()


func _on_Tween_tween_completed(object, key):
	queue_free()


func _on_PowerUp_area_entered(area):
	queue_free()


func _on_LifeTime_timeout():
	queue_free()


func _on_Timer_timeout():
	$AnimatedSprite.frame = 0
	$AnimatedSprite.play()
