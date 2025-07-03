extends Control  # Or HBoxContainer, based on your scene

@onready var spell_buttons := get_children()

func _ready():
	var keys = ["q", "w", "e", "r"]
	for i in range(min(keys.size(), spell_buttons.size())):
		var spell_button = spell_buttons[i]
		if spell_button.has_method("set"):
			spell_button.change_key = keys[i]
