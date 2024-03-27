@tool
extends CollisionPolygon2D
var line2d : Line2D
var original_points : Array
var outlineFactor
var collision_polygon: Polygon2D


func _ready():
	draw.connect(update_line2d)
	for child in get_children():
		if child is Polygon2D:
			collision_polygon = child
			break
	line2d = get_child(0).get_child(0)
	outlineFactor = line2d.width/2
	original_points = get_polygon()


func update_line2d():
	collision_polygon.polygon = get_polygon()
	line2d.clear_points()
	var puntos = get_polygon()

	for punto in puntos:
		line2d.add_point(punto)
		
		if punto == puntos[puntos.size()-1]:
			line2d.add_point(puntos[0])
