@tool
extends CollisionPolygon2D
var line2d : Line2D
var original_points : Array
var outlineFactor
var collision_polygon: Polygon2D

@export var _texture : Texture:
	set(new_value):
		_texture = new_value
		$CollisionPolygon2D6.texture = _texture

@export var _scale : Vector2 = Vector2(1,1):
	set(new_value):
		_scale = new_value
		$CollisionPolygon2D6.texture_scale = _scale

@export var _textureLine : Texture:
	set(new_value):
		_textureLine = new_value
		$CollisionPolygon2D6/Line2D.texture = _textureLine


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
