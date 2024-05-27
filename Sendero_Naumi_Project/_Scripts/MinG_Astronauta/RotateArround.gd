extends Node2D

var d
@export var radius : float 
@export var speed : float
@export var speed2 := 1.0
@export var selfRotation : float
@export var CenterObject : Node2D

func _ready():
	d = CenterObject.position.angle_to_point(position)
	print(d)
	
func _process(delta):
	d += delta * speed2
	global_position = Vector2(sin(d*speed) * radius,cos(d*speed) * radius) + CenterObject.global_position
	rotate(selfRotation*delta)
