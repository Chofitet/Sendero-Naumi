@tool
extends Path2D

@export var anchorMegafauna : Node2D
@export var anchorHistoria : Node2D
@export var anchorGeologia: Node2D
@export var anchorAstronomia : Node2D
@export var anchormegafauna2 : Node2D
@export var anchorErasGeologicas : Node2D
@export var anchorBiodiversidad : Node2D

func _process(delta):
	if !Engine.is_editor_hint(): return
	curve.set_point_position(0,anchorMegafauna.global_position)
	curve.set_point_position(3,anchorHistoria.global_position)
	curve.set_point_position(4,anchorGeologia.global_position)
	curve.set_point_position(6,anchorAstronomia.global_position)
	curve.set_point_position(11,anchormegafauna2.global_position)
	curve.set_point_position(12,anchorErasGeologicas.global_position)
	curve.set_point_position(13,anchorBiodiversidad.global_position)
	var pathPoints = curve.get_baked_points()
	$Line2D.points = pathPoints

func _ready():
	var pathPoints = curve.get_baked_points()
	$Line2D.points = pathPoints
