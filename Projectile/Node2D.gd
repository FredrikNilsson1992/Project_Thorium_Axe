# fierball
extends Area2D

const FIREBALL_SPEED = 200

func _ready():
	set_process(true)

func _process(delta):
	var speed_x = 1
	var speed_y = 0
	var motion = vector2()speed_x, speed_y) * FIREBALL_SPEED
	set_pos(get_pos() + motion * delta)  
