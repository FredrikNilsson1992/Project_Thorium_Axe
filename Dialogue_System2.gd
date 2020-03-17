extends Node


class_name DialogueAction

var dia_index = 1
onready var player_movement = get_node("../../../Player")
onready var text_print = get_node("RichTextLabel")

export (String, FILE, "*.json") var dialogue_file_path : String

func interact() -> void:
	var dialogue : Dictionary = load_dialogue(dialogue_file_path)
	var dialogue_list = dialogue["dialogue"]
	
	if dialogue_list.size() > 1:
		text_print.visible == false
		player_movement.Move_Speed = 0
		text_print.show()
		
		if dia_index != dialogue_list.size() - 1:
			text_print.text = dialogue_list[dia_index]["text"]
			dia_index += 1
		else:
			dia_index = 1
			text_print.hide()
			player_movement.Move_Speed = 5 * 65
	
	elif dialogue_list.size() == 1:
		text_print.visible == false
		player_movement.Move_Speed = 0
		text_print.show()
		text_print.text = dialogue_list[1]["text"]
		
	else:
		text_print.hide()
		player_movement.Move_Speed = 5 * 65

	#yield(Node.play_dialogue(dialogue), "completed")
	#emit_signal("finished")
	


func load_dialogue(file_path) -> Dictionary:
	var file = File.new()
	
	
	file.open(file_path, file.READ)
	var dialogue = parse_json(file.get_as_text())
	
	return dialogue