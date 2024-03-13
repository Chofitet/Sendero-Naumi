@tool
extends CollisionPolygon2D
var line2d : Line2D
var original_points : Array
var outlineFactor

var collision_polygon: Polygon2D

func _input(event):
	if Input.is_action_just_pressed("TouchScreen"):
		print("a")

func _ready():
	for child in get_children():
		if child is Polygon2D:
			collision_polygon = child
			break
	line2d = get_child(0).get_child(0)
	outlineFactor = line2d.width/2
	original_points = get_polygon()

func _process(delta):
	if Engine.is_editor_hint():
		collision_polygon.polygon = get_polygon()
	update_line2d()

func update_line2d():
	line2d.clear_points()
	var puntos = get_polygon()

	for punto in puntos:
		line2d.add_point(punto)
		
		if punto == puntos[puntos.size()-1]:
			line2d.add_point(puntos[0])
