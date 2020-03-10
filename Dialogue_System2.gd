extends Node
class_name DialogueAction

export (String, FILE, "*.json") var dialogue_file_path : String

var dpath = "res://text.json"
var index = 1

var dialogue : Dictionary

func _ready():
	dialogue = load_dialogue(dpath)
	


func interact() -> void:
	
	for i in dialogue['dialogue']:
		get_node("RichTextLabel").text = i["text"]
		yield()
	get_node("RichTextLabel").hide()
	get_node("../../../Player").interact_option = 2
	#get_node("Text_Sprite").show
	#var dialogue_step = 1
	#yield(get_node("RichTextLabel").play_dialogue(dialogue), "completed")
	#emit_signal("finished")
	
func load_dialogue(file_path) -> Dictionary:
	var dialogue = {}
	var file = File.new()
	if !file.file_exists(file_path):
		print("Filen finns inte!!!")
	else:
		print("Filen är hittad!")
	file.open(file_path, File.READ)
	dialogue = parse_json(file.get_as_text())
	file.close()
	return dialogue