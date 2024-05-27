@tool
extends RigidBody2D
var impulse_strength : float

@export var _texture : Texture:
	set(value):
		_texture = value
		$Sprite2D.texture = _texture

@export var color : Color:
	set(value):
		color = value
		$Sprite2D.self_modulate = color
		$Particles.color = color


func Explote(parent):
	freeze = false
	reparent(parent)
	impulse_strength = randf_range(100,400)
	var random_angle = randf_range(PI/2, 3 * PI/2) * -1
	var direction = Vector2(cos(random_angle), sin(random_angle))
	apply_impulse(direction * impulse_strength, direction )

func Appear():
	visible = true
	$Particles.emitting = true
