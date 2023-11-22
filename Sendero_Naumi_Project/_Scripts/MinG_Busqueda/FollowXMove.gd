extends Node2D
@export var target : Node2D

func _ready():
	position.x = target.position.x

func _process(delta):
	
	var target_x = target.global_position.x

	# Calcula la nueva posición en el eje x en sentido contrario al objetivo
	var new_x = 2 * target_x - global_position.x

	# Aplica la nueva posición
	global_position.x = new_x
