extends Node2D

@onready var line = $Line2D
var inPressed
var arrivalPoint
var speed
var incruse : float = 0
var incruse2 : float = 0
var auxbool
signal toBathe

func init(btn,_speed):
	arrivalPoint = $ArrivalPoint
	inPressed = true
	btn.button_up.connect(Button_Up)
	speed = _speed
	auxbool = true

func Button_Up():
	inPressed = false

func _process(delta):
	if auxbool:
		if incruse < arrivalPoint.position.y :
			incruse += delta *  speed
			var pointpos = Vector2(0, incruse)
			line.set_point_position(1,pointpos)
		else:
			toBathe.emit()
	if !inPressed:
		if incruse2 < arrivalPoint.position.y :
			incruse2 += delta * speed
			var pointpos = Vector2(0, incruse2)
			line.set_point_position(0,pointpos)
		else:
			queue_free() 

