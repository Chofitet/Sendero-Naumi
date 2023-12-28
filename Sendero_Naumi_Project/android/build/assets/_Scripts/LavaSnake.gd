extends Node2D

var punta
func _ready():
	punta = get_node("Targets/punta")

func _process(delta):
	punta.position = get_local_mouse_position()
