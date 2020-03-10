extends KinematicBody2D

const UP = Vector2(0, -1)
const SLOPE_STOP = 64

var velocity = Vector2()
var Move_Speed = 5 * 65
var gravity = 1200
var jump_velocity = -720
var is_grounded
var interact = true
var interact_option
var player_anim

var dialog = null

onready var raycasts = $Raycasts

func _physics_process(delta):
	_get_input()
	velocity.y += gravity * delta
	move_and_slide(velocity, UP)
	

	is_grounded = _check_is_grounded()

func _input(event):
	if event.is_action_pressed("jump") && is_grounded:
		velocity.y = jump_velocity

func _get_input():
	var move_direction = -int(Input.is_action_pressed("Move_left")) + int(Input.is_action_pressed("Move_right"))
	velocity.x = lerp(velocity.x, Move_Speed * move_direction, _get_h_weight())
	if move_direction != 0:
		$Body.scale.x = move_direction
	if Input.is_action_just_pressed("interact") and interact_option == 1:
		if !dialog:
			dialog = get_node("../LocalMap/MapAction/DialogueAction").interact()
		else:
			dialog = dialog.resume()
		Move_Speed = 0
	elif Input.is_action_just_pressed("interact") and interact_option == 2:
		#get_node("../LocalMap/MapAction/DialogueAction/RichTextLabel").hide()
		Move_Speed = 5 * 65
	
	
func _get_h_weight():
	return 0.2 if is_grounded else 0.1
		
func _check_is_grounded():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
		return false

func _on_Area2D_body_entered(body):
		#if Input.is_action_just_pressed("interact") and interact_option == 2 or 3:
			#get_node("../LocalMap/MapAction/DialogueAction/RichTextLabel").show() and get_node("../LocalMap/MapAction/DialogueAction/RichTextLabel").text ["002"]["text"]
			#interact_option = 3
		#elif Input.is_action_just_pressed("interact") and interact_option == 3:
			#get_node("../LocalMap/MapAction/DialogueAction/RichTextLabel").show() and get_node("../LocalMap/MapAction/DialogueAction/RichTextLabel").text ["003"]["text"]
			#interact_option = 4
		#else:
	interact_option = 1
	pass

func __on_Area2D_body_exit(body):
	interact_option = 0
	pass
	