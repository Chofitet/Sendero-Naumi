@tool
extends Node2D
class_name rockHinchada
@export var StartWaiting : bool
@export var _texture : Texture:
	set(value):
		_texture = value
		$Rock.texture = _texture
@export var accesorio : Texture

func _ready():
	get_node("Rock").texture = _texture
	get_node("Gorri").texture = accesorio
	if StartWaiting: $AnimationPlayer.play("waiting")

func ChangeTexture(_texture):
	$Rock.texture = _texture

func setAnim(anim : String):
	$AnimationPlayer.play(anim)
