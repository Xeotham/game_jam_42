extends CharacterBody2D

@export var speed: float = 150.0
@export var health: int = 100
@export var damage: int = 10
@export var follow_player: bool = true
@export var detection_radius: float = 200.0

@onready var player = $"../Player1"

func _ready():
	pass

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity.y = 0
	if follow_player and player and is_instance_valid(player):
		var direction = player.global_position - global_position
		if direction.length() < detection_radius:
			velocity.x = direction.normalized().x * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, speed * delta)

	move_and_slide()


func take_damage(amount: int):
	health -= amount
	if health <= 0:
		die()

func die():
	queue_free()
