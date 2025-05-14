extends TextureRect
var motion_value := Vector2.ZERO

func _ready():
	StartMotionMove()

func StartMotionMove():
	var tween := create_tween()
	
	tween.tween_method(_on_tween_step,Vector2.ZERO,Vector2(0,3),40).set_ease(Tween.EASE_IN)

func _on_tween_step(tween):
	print(tween)
	material.set_shader_parameter("motion", tween)
