extends Polygon2D
var line2d : Line2D
var original_points : Array
var outlineFactor


func _ready():
	line2d = $Line2D
	outlineFactor = line2d.width/2
	update_line2d()
	original_points = get_polygon()


func update_line2d():
	line2d.clear_points()
	var puntos = get_polygon()

	for punto in puntos:
		line2d.add_point(punto)
		
		if punto == puntos[puntos.size()-1]:
			line2d.add_point(puntos[0])
