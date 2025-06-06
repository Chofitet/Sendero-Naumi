extends Sprite2D
@export var overlay : ColorRect
@export var NubeAnim : AnimationPlayer
var animation = "Lava_fall"
var initPosition
var time = 1
var wasTransformed
signal PanelAppear
signal TriggerNextTransformation
@export var spot : Sprite2D
func _ready():
	initPosition = position

func TranstaleToCenterScreen(animation):
	PlayerVariables.EmitInactivePause()
	visible = true
	z_index = 2
	overlay.visible = true
	var tween = get_tree().create_tween()
	get_node("AnimationPlayer").play("rockTransformation")
	tween.tween_property(self,"position",get_viewport_rect().size/2 + Vector2(0,-get_viewport_rect().size.y/2 + 340),time).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(2.4).timeout
	get_node("Anim/AnimationPlayer").play("despertar_anim")

func buttonpress():
	time = 0
	z_index = 1
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
	PlayerVariables.EmitActivePause()

func panelAppear():
	PanelAppear.emit()

func MoveToSpot():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"global_position",spot.global_position, 0.3)
	var tween2 = get_tree().create_tween()
	tween2.tween_property(self,"scale",Vector2(0.157,0.157),0.3)
	await tween.finished
	get_parent().get_node("plutonicaSpot").visible = true
	RestartAll()

func RestartAll():
	
	position = initPosition
	visible = false
	get_node("AnimationPlayer").play("RESET")
	get_node("Anim/AnimationPlayer").play("RESET")
