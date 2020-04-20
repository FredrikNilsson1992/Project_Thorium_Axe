extends KinematicBody2D

const UP = Vector2(0, -1)
onready var friction = 0
const GRAVITY = 20
const ACCELERATION = 50
const MAX_SPEED = 200
const JUMP_HEIGT = -550
var interact_option = false
var motion =Vector2()
var talking = 0
onready var camerabox = get_node ("Camera2D/DialogueBox")
onready var Option = get_node ("RichTextLabel")

func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	if Input.is_action_just_pressed("interact") && interact_option == true:
		get_node("../LocalMap/MapAction/DialogueAction").interact()
	if talking == 1:
		camerabox.show()
	elif talking == 0:
		camerabox.hide()

func _input_is_action_pressed():

	if Input.is_action_pressed("ui_right"):
		motion.x =min(motion.x+ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false
		$Sprite.play("Run")
	elif Input.is_action_pressed("ui_left"):
		motion.x =max(motion.x+ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = true
		$Sprite.play("Run")
	else:
		$Sprite.play("Idle")
		friction = true


	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGT
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		if motion.y < 0:
			$Sprite.play("Jump")
		else:
			$Sprite.play("Fall")
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.5)
	motion = move_and_slide(motion, UP)

func _on_Area2D_body_entered(body):
	interact_option = true
	if interact_option == true:
		Option.show
	
func __on_Area2D_body_exit(body):
	interact_option = false
	if interact_option != true:
		Option.hide
