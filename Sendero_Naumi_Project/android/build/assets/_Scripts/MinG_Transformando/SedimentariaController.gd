extends Sprite2D

var timer
@export var overlay : ColorRect

func _ready():
	timer = get_node("SedimentariaTime")
	timer.timeout.connect(FinishFall)

func StartFall():
	timer.start()

func FinishFall():
	get_node("Area2D").call_deferred("SetParent")
	TranstaleToCenterScreen()


func TranstaleToCenterScreen():
	overlay.visible = true
	var tween = get_tree().create_tween()
	get_node("AnimationPlayer").play("rockTransformation")
	tween.tween_property(self,"position",get_viewport_rect().size/2 + Vector2(0,-300),2).set_ease(Tween.EASE_OUT)
	

func buttonpress():
	overlay.visible = false
	get_parent().get_node("sedimentariaSpot").visible = true
	queue_free()
