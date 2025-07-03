extends TextureButton

@onready var progress_bar = $TextureProgressBar
@onready var timer = $Timer
@onready var time = $Time
@onready var key = $Key

signal cast(spell_name)

var change_key := "":
	set(value):
		change_key = value.to_lower()
		key.text = value.to_upper()

		# Crée un raccourci clavier affichable (optionnel)
		shortcut = Shortcut.new()
		var input_key = InputEventKey.new()
		input_key.keycode = change_key.unicode_at(0)
		shortcut.events = [input_key]

func _ready():
	progress_bar.max_value = timer.wait_time
	set_process(true)  # on veut que _process tourne

func _process(_delta):
	# Affiche le cooldown s’il est actif
	if timer.time_left > 0:
		time.text = "%3.1f" % timer.time_left
		progress_bar.value = timer.time_left
	else:
		time.text = ""
		progress_bar.value = 0

	# Vérifie si la touche correspondante est pressée
	if !disabled and Input.is_action_just_pressed("spell_" + change_key):
		_on_pressed()

func _on_pressed():
	timer.start()
	disabled = true
	set_process(true)
	cast.emit(name)  # Émet un signal si besoin

func _on_timer_timeout():
	disabled = false
	time.text = ""
	set_process(true)
