extends Node2D

var lava_drop_scene = preload("res://Scenes/Zona_Geología/lava_drop.tscn")
var timer
var i = 0

func _ready():
	timer = get_node("Timer")
	timer.timeout.connect(SpawnLavaDrop)

func StartTimer():
	timer.start()
	var lavadrop = lava_drop_scene.instantiate()
	add_child(lavadrop)
	lavadrop.position = Vector2(0,0)

func SpawnLavaDrop():
	var lavadrop = lava_drop_scene.instantiate()
	add_child(lavadrop)
	lavadrop.position = Vector2(0,0)
	
	i = i + 1
	if i >= 2:
		timer.stop()

