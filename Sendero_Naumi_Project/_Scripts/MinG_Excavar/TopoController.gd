extends Node2D
var pressedPos: Vector2
var topo
var isMoving 
var line

func _ready():
	topo = $topo
	line = $Line2D

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("TouchScreen"):
		isMoving = true 
		pressedPos = event.position
		
	if Input.is_action_just_released("TouchScreen"):
		isMoving = false
		

func _process(delta):
	if !isMoving: return
	topo.look_at(pressedPos) 
	topo.move_local_x(delta*200,false)
	var relative_position = topo.global_position - line.global_position
	line.add_point(relative_position)

