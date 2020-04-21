var dialogue = {
    "intro": {
        "dialogue":
            "Character dialogue",
        "affirmative": {
            "text": "Yes",
            "value": "example_effect"
        },
        "negative": {
            "text": "No",
            "value": ""
        }
    },
    "example_effect": {
        "func": "",
        "args": []
    }
} setget set_dialogue

var state = {} setget set_state

func _ready():
    set_state(dialogue["intro"])
    process_state(state)
    pass

func change_scene(scene):
    #get_tree().change_scene(scene)
    pass

func set_state(new_state):
    state = new_state
    pass

func set_dialogue(new_dialogue):
    dialogue = new_dialogue
    pass

func display_state(state):
    $label.text = state["dialogue"]
    $affirmative/label.text = state["affirmative"]["text"]
    $negative/label.text = state["negative"]["text"]
    pass

func process_state(state):
    if state.has("func"):
        return callv(state["func"], state["args"])
    if state.has("dialogue"):
        display_state(state)
    pass

func _on_affirmative_pressed():
    state = dialogue[state["affirmative"]["value"]]
    process_state(state)
    pass

func _on_negative_pressed():
    state = dialogue[state["negative"]["value"]]
    process_state(state)
    pass