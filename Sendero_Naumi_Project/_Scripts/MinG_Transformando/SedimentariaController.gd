extends Sprite2D

var timer
@export var overlay : ColorRect
@export var nubeAnim : AnimationPlayer
@export var UnfreezeRocks :=[]
var initPosition
var wasTransformed
signal PanelAppear
signal TriggerNextTransformation

func _ready():
	initPosition = position
	timer = get_node("SedimentariaTime")
	timer.timeout.connect(FinishFall)

func StartFall():
	timer.start()
	await get_tree().create_timer(1.5).timeout
	for i in UnfreezeRocks:
		get_node(i).UnfrezeeAll()
	await  get_tree().create_timer(2).timeout
	print("30 fps")
	Engine.set_physics_ticks_per_second(30)
	await  get_tree().create_timer(2).timeout
	print("60 fps")
	Engine.set_physics_ticks_per_second(60)

func FinishFall():
	get_node("Area2D").call_deferred("SetParent")
	for i in UnfreezeRocks:
		get_node(i).Freeze()


func TranstaleToCenterScreen(time):
	visible = true
	overlay.visible = true
	var tween = get_tree().create_tween()
	get_node("AnimationPlayer").play("rockTransformation")
	tween.tween_property(self,"position",get_viewport_rect().size/2 + Vector2(0,-get_viewport_rect().size.y/2 + 340),time).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(2.4).timeout
	get_node("Anim/AnimationPlayer").play("anim_despertar")

func buttonpress():
	overlay.visible = false
	nubeAnim.play("RESET")
	get_parent().get_node("sedimentariaSpot").visible = true
	get_parent().get_node("ButtonsInfoController").ActiveButtons()
	RestartAll()
	
	if wasTransformed : return
	wasTransformed = true
	TriggerNextTransformation.emit()

func panelAppear():
	PanelAppear.emit()

func RestartAll():
	position = initPosition
	visible = false
	get_node("AnimationPlayer").play("RESET")
	get_node("Anim/AnimationPlayer").play("RESET")
