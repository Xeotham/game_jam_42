extends Area2D

@onready var body = $".."
@onready var sprite = $"../AnimatedSprite2D"
var agro = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	body.set_player(agro)


func _on_body_entered(body: Node2D) -> void:
	agro = body
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	agro = null
	sprite.play("idle")
	pass # Replace with function body.
