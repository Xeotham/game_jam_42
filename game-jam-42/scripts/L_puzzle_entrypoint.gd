extends Area2D

var wired = false
var areaWired = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in areaWired.keys():
		if i.get("wired"):
			wired = true
			$"../Puzzle00".texture = load("res://assets/puzzle/puzzle_05_wired.png")
			return
	$"../Puzzle00".texture = load("res://assets/puzzle/puzzle_05.png")
	wired = false


func _on_area_entered(area: Area2D) -> void:
	#print("Wired: ", area)
	areaWired[area] = area.get("wired")
	for i in areaWired.values():
			if i:
				wired = true
				$"../Puzzle00".texture = load("res://assets/puzzle/puzzle_05_wired.png")
				return
	$"../Puzzle00".texture = load("res://assets/puzzle/puzzle_05.png")
	wired = false


func _on_area_exited(area: Area2D) -> void:
	areaWired.erase(area.name)
	for i in areaWired.values():
		if i:
			return
	$"../Puzzle00".texture = load("res://assets/puzzle/puzzle_05.png")
	wired = false
