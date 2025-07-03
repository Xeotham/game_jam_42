extends Area2D

@export var wired = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#
#func _on_area_entered(area: Area2D) -> void:
	#print("Area entered: ", area)
	#area.set("wired", true)
	#pass
#
#func _on_area_exited(area: Area2D) -> void:
	#print("Area exited: ", area)
	#area.set("wired", false)
	#pass
