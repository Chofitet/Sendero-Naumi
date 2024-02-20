@tool
extends Sprite2D

var sauce_material : ShaderMaterial
var is_button_pressed : bool = false
var _time

func _process(delta):
	_time += delta
	material.set_shader_parameter("time", _time)
