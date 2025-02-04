extends Sprite2D
var heat1
var i = 0.6
var e = 0
var heateffect
var initPosition
@export var overlay : ColorRect
@export var nubeAnim : AnimationPlayer
var anim
var time = 1
signal PanelAppear
signal TriggerNextTransformation
var wasTransformed

func _ready():
	initPosition = position
	heateffect = get_node("PiedraHeat1")
	heateffect.self_modulate = Color(0.6,0.6,0.6,0)
	anim = get_node("AnimCalor/AnimationPlayer")


func _physics_process(delta):
	if heat1:
		i -= delta * 0.08
		i = clamp(i,0,1)
		self_modulate = Color(0.6, i, i, 1)
		if i <= 0.5:
			e += delta * 0.08
			e = clamp(e,0,1)
			heateffect.self_modulate = Color(1,0.85,0.64,e)

func Heat1():
	heat1 = true
	anim.play("anim_calor1")
	z_index = 2

func TranstaleToCenterScreen():
	visible = true
	overlay.visible = true
	var tween = get_tree().create_tween()
	get_node("AnimationPlayer").play("rockTransformation")
	tween.tween_property(self,"position",get_viewport_rect().size/2 + Vector2(0,-get_viewport_rect().size.y/2 + 340),time).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(2.4).timeout
	get_node("Anim/AnimationPlayer").play("anim_despertar")
	
func panelAppear():
	PanelAppear.emit()

func buttonpress():
	time = 0
	overlay.visible = false
	nubeAnim.play("RESET")
	get_parent().get_node("metamorficaSpot").visible = true
	get_parent().get_node("ButtonsInfoController").ActiveButtons()
	RestartAll()
	if wasTransformed : return
	wasTransformed = true
	TriggerNextTransformation.emit()

func AnimLoop():
	anim.play("anim_calor2")

func RestartAll():
	position = initPosition
	visible = false
	get_node("AnimationPlayer").play("RESET")
	get_node("Anim/AnimationPlayer").play("RESET")
