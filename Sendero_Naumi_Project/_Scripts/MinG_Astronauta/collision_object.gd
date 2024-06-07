@tool
extends RigidBody2D

@export var _texture: Texture:
	set(value):
		_texture = value
		$Sprite2D.texture = _texture
