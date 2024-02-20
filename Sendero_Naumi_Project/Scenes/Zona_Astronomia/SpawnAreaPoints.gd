extends Node2D
@onready var point1 = $SpawnPoint1
@onready var point2 = $SpawnPoint2
@export var Parent : Node2D
@export var toInstance : PackedScene

func Spawn():
	var vectorAreaSpawn = point2.global_position - point1.global_position 
	var posicion_aleatoria = point1.global_position + vectorAreaSpawn * randf()
	var instanciate = toInstance.instantiate()
	instanciate.position = posicion_aleatoria
	Parent.add_child(instanciate)

