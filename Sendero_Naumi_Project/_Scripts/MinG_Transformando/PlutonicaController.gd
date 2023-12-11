extends Sprite2D
@export var overlay : ColorRect
@export var NubeAnim : AnimationPlayer
var animation = "Lava_fall"
var initPosition
var time = 2

func _ready():
	initPosition = position

func TranstaleToCenterScreen(animation):
	get_parent().get_node("plutonicaSpot").visible = false
	visible = true
	z_index = 2
	overlay.visible = true
	var tween = get_tree().create_tween()
	get_node("AnimationPlayer").play("rockTransformation")
	tween.tween_property(self,"position",get_viewport_rect().size/2 + Vector2(0,-get_viewport_rect().size.y/2 + 340),time).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(4.4).timeout
	get_node("Anim/AnimationPlayer").play("despertar_anim")

func buttonpress():
	time = 0
	z_index = 1
	overlay.visible = false
	get_parent().get_node("plutonicaSpot").visible = true
	NubeAnim.play("RESET")
	get_parent().get_node("ButtonsInfoController").ActiveButtons()
	RestartAll()


func RestartAll():
	
	position = initPosition
	visible = false
	get_node("AnimationPlayer").play("RESET")
	get_node("Anim/AnimationPlayer").play("RESET")
