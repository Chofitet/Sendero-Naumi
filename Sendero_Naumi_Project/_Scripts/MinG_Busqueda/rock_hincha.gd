extends Node2D
@export var _texture : Texture
@export var accesorio : Texture

func _ready():
	get_node("Rock").texture = _texture
	get_node("Gorri").texture = accesorio

func ChangeTexture(_texture):
	$Rock.texture = _texture
