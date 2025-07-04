extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -300.0

var jump_count = 0
var jump_total = 1
var air_time = 0
var actual_position = Vector2.ZERO

@onready var camera = $Camera2D as Camera2D
@onready var Health = $Health

var MaxHealth = 150
var health = 50

func _ready() -> void:
	$MultiplayerSynchronizer.set_multiplayer_authority(1)
	if multiplayer.get_unique_id() == 1:
		camera.make_current()

func _physics_process(delta: float) -> void:
	if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		if is_on_floor():
			jump_count = 0
			air_time = 0
		else:
			air_time += 1
		
		if air_time > 10 and jump_count < 1:
			jump_count += 1

		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and jump_count < jump_total:
			velocity.y = JUMP_VELOCITY
			jump_count += 1

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		actual_position = velocity
		move_and_slide()

func take_damage(amount: int):
	health -= amount
	if health < 0: health = 0
	Health.change_health(-amount)

func die():
	queue_free()
