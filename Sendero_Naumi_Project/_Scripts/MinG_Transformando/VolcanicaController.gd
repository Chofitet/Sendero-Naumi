extends Sprite2D
@export var overlay : ColorRect

func TranstaleToCenterScreen(animation):
	z_index = 2
	overlay.visible = true
	var tween = get_tree().create_tween()
	get_node("AnimationPlayer").play("rockTransformation")
	var tween2 = get_tree().create_tween()
	tween.tween_property(self,"position",get_viewport_rect().size/2 + Vector2(0,-300),2).set_ease(Tween.EASE_OUT)
	tween2.tween_property(self,"rotation",0,2)

func buttonpress():
	overlay.visible = false
	get_parent().get_node("plutonicaSpot").visible = true
	queue_free()
