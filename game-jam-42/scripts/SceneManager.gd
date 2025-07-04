extends Node2D

@export var PlayerScene: PackedScene
@onready var player1 = $Player1
@onready var player2 = $Player2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var player1 = load("res://scenes/player_1.tscn").instantiate()
	#var player2 = load("res://scenes/player_2.tscn").instantiate()
	#
	#add_child(player1)
	#add_child(player2)

	
	#player1.global_position = $Spawn.global_position
	#player2.global_position = $Spawn.global_position
	
	GameManager.sprite1 = player1
	GameManager.sprite2 = player2
	
	var enemys = [$Enemys/Enemy1]
	
	for i in enemys:
		var ennemy: Ennemy = i
		ennemy.set_player(player1)
			
	if multiplayer.get_unique_id() != 1:
		$CanvasModulate.hide()
		$ParallaxBackground/CanvasModulate.hide()
		$"Invisible Enemys/EnemyBody".show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
