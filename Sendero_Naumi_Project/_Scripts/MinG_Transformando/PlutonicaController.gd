extends Sprite2D
@export var overlay : ColorRect
var animation = "Lava_fall"

func TranstaleToCenterScreen(animation):
	z_index = 2
	overlay.visible = true
	var tween = get_tree().create_tween()
	get_node("AnimationPlayer").play("rockTransformation")
	tween.tween_property(self,"position",get_viewport_rect().size/2 + Vector2(0,-get_viewport_rect().size.y/4),2).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(4.4).timeout
	get_node("Anim/AnimationPlayer").play("despertar_anim")

func buttonpress():
	z_index = 1
	overlay.visible = false
	get_parent().get_node("plutonicaSpot").visible = true
	queue_free()
