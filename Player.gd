extends KinematicBody2D

const UP = Vector2(0, -1)

var velocity = Vector2()
var Move_Speed = 5 * 85
var gravity = 1200


func _physics_process(delta):
	_get_input()
	velocity.y += gravity * delta
	move_and_slide(velocity, UP)
	pass 

func _get_input():
	var move_direction = -int(Input.is_action_pressed("Move_left")) + int(Input.is_action_pressed("Move_left"))
	velocity.x = lerp(velocity.x, Move_Speed * move_direction, 0.2)
	if move_direction != 0:
		$Body.scale.x = move_direction