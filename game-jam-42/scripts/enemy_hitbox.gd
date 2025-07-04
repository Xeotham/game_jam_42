extends Area2D

@onready var enemy_body = $".." as Ennemy
@onready var sprite = $"../AnimatedSprite2D"

var hit = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	enemy_body.set_hit(hit)

func _on_body_entered(body: Node2D) -> void:
	sprite.stop()
	hit = true
	enemy_body.set_hit(true)


func _on_body_exited(body: Node2D) -> void:
	sprite.play("agro")
	hit = false
	enemy_body.set_hit(false)
