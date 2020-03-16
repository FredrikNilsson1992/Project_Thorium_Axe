extends KinematicBody2D


const UP = Vector2(0, -1)
const SLOPE_STOP = 64

var velocity = Vector2()
var Move_Speed = 5 * 65
var gravity = 1200
var jump_velocity = -720
var is_grounded
var interact = true
var interact_option = false

onready var raycasts = $Raycasts

func _physics_process(delta):
	_get_input()
	velocity.y += gravity * delta
	move_and_slide(velocity, UP)
	if Input.is_action_just_pressed("interact") && interact_option == true:
		get_node("../LocalMap/MapAction/DialogueAction").interact()
	

	is_grounded = _check_is_grounded()

func _input(event):
	if event.is_action_pressed("jump") && is_grounded:
		velocity.y = jump_velocity

func _get_input():
	var move_direction = -int(Input.is_action_pressed("Move_left")) + int(Input.is_action_pressed("Move_right"))
	velocity.x = lerp(velocity.x, Move_Speed * move_direction, _get_h_weight())
	if move_direction != 0:
		$Body.scale.x = move_direction
		
		
func _get_h_weight():
	return 0.2 if is_grounded else 0.1
		
func _check_is_grounded():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
		return false



func _on_Area2D_body_entered(body):
	interact_option = true
	
func __on_Area2D_body_exit(body):
	interact_option = false
	