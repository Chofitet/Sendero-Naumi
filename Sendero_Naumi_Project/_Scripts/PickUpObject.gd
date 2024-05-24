@tool
extends Area2D
signal  Picked
signal Crash
@onready var reaplaceMeteoro = preload("res://Scenes/Zona_Astronomia/meteorito_body.tscn")
@export var MeteoritoTarget : Marker2D
@export var _texture : Texture:
	set (new_value):
		_texture = new_value
@export var rotation_speed : float
var isMeteorito

func _ready():
	$Sprite2D.texture = _texture
	area_entered.connect(PickObject)

func PickObject(x):
	if x.is_in_group("Player"):
		if !isMeteorito: 
			Picked.emit()
			return
		Crash.emit()
		var instance = reaplaceMeteoro.instantiate()
		x.get_parent().DoCrash()
		get_parent().get_parent().add_child(instance)
		instance.top_level = true
		instance.z_index = 1
		get_parent().get_node("Trial").DuplicyPop_back()
		get_parent().get_node("Trial").reparent(instance)
		instance.global_position = global_position
		instance.applyForce(x,MeteoritoTarget)


func _process(delta):
	rotate(rotation_speed*delta)

func ConvertToMeteorito():
	isMeteorito = true
