extends Node2D

var d := 0.0
@export var radius : float 
@export var speed : float
@export var CenterObject : Node2D

func _process(delta):
	d += delta 
	global_position = Vector2(sin(d*speed) * radius,cos(d*speed) * radius) + CenterObject.global_position
