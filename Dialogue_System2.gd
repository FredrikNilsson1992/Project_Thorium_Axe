extends Node


class_name DialogueAction


onready var text_print = get_node("LocalMap/MapAction/DialogueAction/RichTextLabel")


export (String, FILE, "*.json") var dialogue_file_path : String


func interact() -> void:
	var dialogue : Dictionary = load_dialogue(dialogue_file_path)
	yield(Node.play_dialogue(dialogue), "completed")
	emit_signal("finished")
	text_print.text(dialogue[001]["text"])



func load_dialogue(file_path) -> Dictionary:
	var file = File.new()
	assert file.file_exists(file_path)
	
	file.open(file_path, file.READ)
	var dialogue = parse_json(file.get_as_text())
	assert dialogue.size() > 0
	return dialogue