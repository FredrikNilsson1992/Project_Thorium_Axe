extends Node
class_name DialogueAction

export (String, FILE, "*.json") var dialogue_file_path : String
var dpath = "text.json"

func interact() -> void:
	var dialogue : Dictionary = load_dialogue(dpath)
	get_node("../../../RichTextLabel").text = dialogue["001"]["text"]
	#yield(get_node("../NPC/Grimdor").play_dialogue(dialogue), "completed")
	#emit_signal("finished")
	
func load_dialogue(file_path) -> Dictionary:
	var file = File.new()
	assert file.file_exists(file_path)
	
	file.open(file_path, file.READ)
	var dialogue = parse_json(file.get_as_text())
	assert dialogue.size() > 0
	return dialogue