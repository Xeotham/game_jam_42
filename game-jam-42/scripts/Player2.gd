extends CharacterBody2D


@export var MAX_SPEED = 300.0
@export var ACCELERATION = 1500.0
@export var FRICTION = 1700

@onready var axis = Vector2.ZERO
@onready var camera = $Camera2D as Camera2D

func _ready() -> void:
	var playerId
	for i in GameManager.Players:
		if i != 1:
			playerId = i
	$MultiplayerSynchronizer.set_multiplayer_authority(playerId)
	if multiplayer.get_unique_id() != 1:
		$PointLight2D.hide()
		camera.make_current()
		$HUDspell.show()

func get_input_axis():
	axis.x = int(Input.is_action_pressed("Player2_move_right")) - int(Input.is_action_pressed("Player2_move_left"))
	axis.y = int(Input.is_action_pressed("Player2_move_down")) - int(Input.is_action_pressed("Player2_move_up"))
	return axis.normalized()

func move(delta):
	axis = get_input_axis()
	
	if axis == Vector2.ZERO:
		apply_friction(FRICTION * delta)
	else:
		apply_movement(axis * ACCELERATION * delta)
		
	move_and_slide()

func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO

func apply_movement(accel):
	velocity += accel
	velocity = velocity.limit_length(MAX_SPEED)

func _physics_process(delta: float) -> void:
	if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		move(delta)
