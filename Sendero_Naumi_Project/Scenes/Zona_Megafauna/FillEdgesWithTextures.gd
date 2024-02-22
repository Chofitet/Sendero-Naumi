@tool
extends Polygon2D

@export var line2d : Line2D

var original_points : Array

func _process(delta):
	update_line2d()
	original_points = get_polygon()

func update_line2d():
	line2d.clear_points()
	var puntos = get_polygon()

	for punto in puntos:
		line2d.add_point(punto)
		if punto == puntos[puntos.size()-1]:
			line2d.add_point(puntos[0])
		
		if punto.distance_to(puntos[puntos.find(punto)-1]) < 20:
			line2d.width_curve.add_point(getXPointCurve(),0.6)

func getXPointCurve() -> float:
	line2d.get_
