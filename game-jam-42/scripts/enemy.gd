extends CharacterBody2D
class_name Ennemy

@export var SPEED = 150.0
@export var HEALTH = 10
@export var DAMAGE = 2
@export var FOLLOW_PLAYER = true
@export var DETECTION_RADIUS = 200.0

var player: Node2D = GameManager.sprite1
@onready var sprite = $AnimatedSprite2D

func _ready():
	_animations()
	pass

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity.y = 0
	detect_player(delta)

	move_and_slide()

func detect_player(delta):
	if FOLLOW_PLAYER and player and is_instance_valid(player):
		var direction = player.global_position - global_position
		if direction.length() < DETECTION_RADIUS:
			sprite.play("agro")
			velocity.x = direction.normalized().x * SPEED
	if !player:
		sprite.play("idle")
	velocity.x = move_toward(velocity.x, 0, SPEED * delta)
	if velocity.x < 0:
		sprite.flip_h = true
	if velocity.x > 0:
		sprite.flip_h = false
		

func take_damage(amount: int):
	HEALTH -= amount
	if HEALTH <= 0:
		die()

func die():
	queue_free()

func set_player(p: Node2D):
	player = p
	
func _animations():
	sprite.play("idle")

	if velocity.x < 0:
		sprite.flip_h = true
	if velocity.x > 0:
		sprite.flip_h = false
