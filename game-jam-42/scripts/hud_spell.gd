extends Control  # ou CanvasLayer

@onready var spellbar = $SpellBar

func _ready():
	var keys = ["q", "w", "e", "r"]
	for i in range(min(keys.size(), spellbar.get_child_count())):
		var spell_button = spellbar.get_child(i)
		spell_button.change_key = keys[i]
