extends Control  # Or HBoxContainer, etc.

@onready var spell_buttons := get_children()

func _ready():
	var keys = ["q", "w", "e", "r"]
	var cooldowns = [2.0, 3.5, 5.0, 7.0]  # Cooldowns for each button

	for i in range(min(keys.size(), spell_buttons.size())):
		var spell_button = spell_buttons[i]
		spell_button.change_key = keys[i]
		spell_button.timer.wait_time = cooldowns[i]
		spell_button.cooldown = cooldowns[i]
