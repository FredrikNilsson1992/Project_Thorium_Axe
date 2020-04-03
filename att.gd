extends Area2D

signal attack_finished

onready var animatio_player = $AnimationPlayer

enum STATES {IDLE, ATTACK}
var current_state = IDLE

export(int) var damage = 1


func _ready():
	set_physics_process(false)


func attack():
	_change_state(attack)


func _change_state(new_state):
	current_state = new_state

	match current_state:
		IDLE:
			set_physics_process(false)
		ATTACK:
			set_physics_process(true)
			animation_player.play("attack")


func _physics_process(delta):
	var overlapping_bodies = get_overlapping_bodies()
	if not overlapping_bodies:
		return
		
	for body in overlapping_bodies:
		if not body.is_in_group("character"):
			return
		if is_owner(body):
			return
		body.take_damege()
	set_physics_process(false)


func is_owner(node):
	return node.wapons_path == get_path()


func _on_AnimationPlayer_animation_animation_finisher( name ):
	if name == "attack":
		_change_state(IDLE)
		emit_signal("attack_finished")
