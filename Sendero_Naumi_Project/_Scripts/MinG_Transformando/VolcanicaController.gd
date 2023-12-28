extends Sprite2D
@export var overlay : ColorRect
@export var NubeAnim : AnimationPlayer
var initPosition
var initRotation
var time = 2

func _ready():
	initPosition =  position
	initRotation = rotation

func TranstaleToCenterScreen(animation):
	visible = true
	z_index = 2
	overlay.visible = true
	var tween = get_tree().create_tween()
	get_node("AnimationPlayer").play("rockTransformation")
	var tween2 = get_tree().create_tween()
	tween.tween_property(self,"position",get_viewport_rect().size/2 + Vector2(0,-get_viewport_rect().size.y/2 + 340),time).set_ease(Tween.EASE_OUT)
	tween2.tween_property(self,"rotation",0,2)
	await get_tree().create_timer(4.4).timeout
	get_node("Anim/AnimationPlayer").play("anim_despertar")

func buttonpress():
	time = 0
	overlay.visible = false
	NubeAnim.play("RESET")
	get_parent().get_node("VulcanicaSpot").visible = true
	get_parent().get_node("ButtonsInfoController").ActiveButtons()
	get_parent().get_node("EndGamePanel").visible = true
	RestartAll()


func RestartAll():
	rotation = initRotation
	position = initPosition
	visible = false
	get_node("AnimationPlayer").play("RESET")
	get_node("Anim/AnimationPlayer").play("RESET")

