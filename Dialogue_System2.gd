extends Node


class_name DialogueAction
var talking = 0
var dia_index = 1
onready var player_movement = get_node("../../../Player")
onready var text_print = get_node("../../../Player/Camera2D/RichTextLabel")
onready var dialogue_box = get_node("../../../Player/Camera2D/DialogueBox")
export (String, FILE, "*.json") var dialogue_file_path : String

func interact() -> void:
	var dialogue : Dictionary = load_dialogue(dialogue_file_path)
	var dialogue_list = dialogue["dialogue"]
	
		
	if dialogue_list.size() > 1:
		text_print.visible == false
		text_print.show()
		get_node("../../../Player/").talking = 1
		
		if dia_index != dialogue_list.size() - 1:
			text_print.text = dialogue_list[dia_index]["text"]
			dia_index += 1
		else:
			get_node("../../../Player/").talking = 0
			dia_index = 1
			text_print.hide()
	
	elif dialogue_list.size() == 1:
		text_print.visible == false
		text_print.show()
		text_print.text = dialogue_list[1]["text"]
		
	else:
		
		text_print.hide()
		
	
	#yield(Node.play_dialogue(dialogue), "completed")
	#emit_signal("finished")
	


func load_dialogue(file_path) -> Dictionary:
	var file = File.new()
	
	
	file.open(file_path, file.READ)
	var dialogue = parse_json(file.get_as_text())
	
	return dialogue
