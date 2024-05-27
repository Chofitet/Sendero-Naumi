@tool
extends Node2D
@export var _texture : Texture:
	set(value):
		_texture = value
		$Rock.texture = _texture
@export var accesorio : Texture

func _ready():
	get_node("Rock").texture = _texture
	get_node("Gorri").texture = accesorio

func ChangeTexture(_texture):
	$Rock.texture = _texture
