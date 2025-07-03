extends CharacterBody2D

@export var SPEED = 150.0
@export var HEALTH = 10
@export var DAMAGE = 2
@export var FOLLOW_PLAYER = true
@export var DETECTION_RADIUS = 200.0

@onready var player = $"../Player1"

func _ready():
	pass

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity.y = 0
	if FOLLOW_PLAYER and player and is_instance_valid(player):
		var direction = player.global_position - global_position
		if direction.length() < DETECTION_RADIUS:
			velocity.x = direction.normalized().x * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)

	move_and_slide()

func take_damage(amount: int):
	HEALTH -= amount
	if HEALTH <= 0:
		die()

func die():
	queue_free()
