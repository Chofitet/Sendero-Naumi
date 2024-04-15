@tool
extends Area2D


@export var _texture : Texture:
	set (new_value):
		_texture = new_value
@export var rotation_speed : float

func _ready():
	$Sprite2D.texture = _texture
	area_shape_entered.connect(PickObject)
	$CollisionShape2D.shape.radius = $Sprite2D.scale.x

func PickObject(x):
	pass

func _process(delta):
	rotate(rotation_speed*delta)
