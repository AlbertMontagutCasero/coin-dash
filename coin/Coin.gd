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
								Color(1,1,1,1),
								Color(1,1,1,0),
								0.3,
								Tween.TRANS_QUAD,
								Tween.EASE_IN_OUT)


func pickup():
	monitoring = false # monitoring disables the ara enter and exit signals from Area2D
	$Tween.start()


func _on_Tween_tween_completed(object, key):
	queue_free()
