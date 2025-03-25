extends Sprite2D
@export var overlay : ColorRect
@export var NubeAnim : AnimationPlayer
var initPosition
var initRotation
var time = 1
var wasTransformed
signal PanelAppear
signal TriggerNextTransformation
@export var spot : Sprite2D
func _ready():
	initPosition =  position
	initRotation = rotation

func TranstaleToCenterScreen(animation):
	PlayerVariables.EmitInactivePause()
	visible = true
	z_index = 2
	overlay.visible = true
	var tween = get_tree().create_tween()
	get_node("AnimationPlayer").play("rockTransformation")
	var tween2 = get_tree().create_tween()
	tween.tween_property(self,"position",get_viewport_rect().size/2 + Vector2(0,-get_viewport_rect().size.y/2 + 340),time).set_ease(Tween.EASE_OUT)
	tween2.tween_property(self,"rotation",0,2)
	await get_tree().create_timer(2.4).timeout
	get_node("Anim/AnimationPlayer").play("anim_despertar")

func buttonpress():
	time = 0
	overlay.visible = false
	
	get_parent().get_node("ButtonsInfoController").ActiveButtons()
	#RestartAll()
	
	if wasTransformed : 
		NubeAnim.play("RESET")
		NubeAnim.play("disappear")
		RestartAll()
		return
	
	MoveToSpot()
	wasTransformed = true
	TriggerNextTransformation.emit()

func panelAppear():
	PanelAppear.emit()

func MoveToSpot():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"global_position",spot.global_position, 0.3)
	var tween2 = get_tree().create_tween()
	tween2.tween_property(self,"scale",Vector2(0.24,0.24),0.3)
	var tween3 = get_tree().create_tween()
	tween3.tween_property(self,"rotation",deg_to_rad(62), 0.3)
	await tween.finished
	get_parent().get_node("VulcanicaSpot").visible = true
	RestartAll()
	
func RestartAll():
	rotation = initRotation
	position = initPosition
	visible = false
	get_node("AnimationPlayer").play("RESET")
	get_node("Anim/AnimationPlayer").play("RESET")

