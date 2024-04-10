extends Control
@onready var CalendarioEn = $Enero/Calendario_Enero
@export var radius_facus : float
var isfocusing : bool
var index
@export var container : Control

func _ready():
	radius_facus = CalendarioEn.material.get_shader_parameter("focus_radius")
	CalendarioEn.material.set_shader_parameter("focus_radius", 1);

func AnimCircleFocus():
	isfocusing = true
	index = 1
#	var tween = get_tree().create_tween()
#	print(radius_facus)
#	tween.tween_method(set_shader_value, 1, 0.29, 10)

func set_shader_value(value):
	CalendarioEn.material.set_shader_parameter("focus_radius", value);


func _process(delta):
	if isfocusing:
		index -= delta 
		CalendarioEn.material.set_shader_parameter("focus_radius", index);
		if index <= radius_facus:
			isfocusing = false
			container.visible = true
