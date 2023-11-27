extends Node2D
@export var _texture : Texture

func _ready():
	get_node("Rock").texture = _texture
