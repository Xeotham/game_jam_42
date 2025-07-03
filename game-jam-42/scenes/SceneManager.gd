extends Node2D

@export var PlayerScene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player1 = load("res://scenes/player_1.tscn").instantiate()
	var player2 = load("res://scenes/player_2.tscn").instantiate()
	
	add_child(player1)
	add_child(player2)
	
	player1.global_position = $Spawn.global_position
	player2.global_position = $Spawn.global_position
	
	var enemy = load("res://scenes/enemy.tscn").instantiate()
	add_child(enemy)
	enemy.set_player(player1)
	
	enemy.global_position = $Enemy.global_position
	
	if multiplayer.get_unique_id() != 1:
		$CanvasModulate.hide()
		#$CanvasModulate2.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
