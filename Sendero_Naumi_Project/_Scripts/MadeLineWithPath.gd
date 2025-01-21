@tool
extends Path2D
var verticalValue

@onready var line = $Line2D
@export var AnchorsIslands :=[Control]
@export var HasAnchors : bool
var NumOfPoint  = [0,3,4,6,11,12,13] 

func _ready():
	if Engine.is_editor_hint() : return
	verticalValue = get_parent().get_parent().size.y + get_viewport_rect().size.y/2
	get_parent().position.y = verticalValue

func _process(delta):
	if !Engine.is_editor_hint() : return
	PositionSparcklePath()

func PositionSparcklePath():
	var i = 0
	if HasAnchors:
		for _points in NumOfPoint:
			curve.set_point_position(_points,get_node(AnchorsIslands[i]).global_position)
			i += 1

	
	line.points = curve.get_baked_points()
