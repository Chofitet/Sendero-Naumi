extends Sprite2D
var heat1
var i = 1
var e = 0
var heateffect
@export var overlay : ColorRect
func _ready():
	heateffect = get_node("PiedraHeat1")
	heateffect.self_modulate = Color(1,0.85,0.64,0)

func _physics_process(delta):
	if heat1:
		i -= delta * 0.08
		i = clamp(i,0,1)
		self_modulate = Color(1, i, i, 1)
		if i <= 0.5:
			e += delta * 0.08
			e = clamp(e,0,1)
			heateffect.self_modulate = Color(1,0.85,0.64,e)

func Heat1():
	heat1 = true
	z_index = 2

func TranstaleToCenterScreen():
	overlay.visible = true
	var tween = get_tree().create_tween()
	get_node("AnimationPlayer").play("rockTransformation")
	tween.tween_property(self,"position",get_viewport_rect().size/2 + Vector2(0,-300),2).set_ease(Tween.EASE_OUT)

func buttonpress():
	overlay.visible = false
	get_parent().get_node("metamorficaSpot").visible = true
	queue_free()
