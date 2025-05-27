@tool
extends Node2D
@onready var initRot = rotation
@export var Colortxt : String
@export var ParteArriba : Texture: 
	set(new_value):
		ParteArriba = new_value
		$pivot/Arriba/pivotRot/Sprite2D.texture = ParteArriba
		AdjustRotationPivot()

@export var ParteArriba2 : Texture: 
	set(new_value):
		ParteArriba2 = new_value
		$pivot/Arriba/pivotRot/Sprite2D/parte2.texture = ParteArriba2

@export var ParteAbajo : Texture:
	set(new_value):
			ParteAbajo = new_value
			$pivot/Abajo/pivotRot/Sprite2D.texture = ParteAbajo

@export var ParteAbajoS : Texture:
	set(new_value):
			ParteAbajoS = new_value
			$pivot/Abajo/pivotRot/Sprite2D2.texture = ParteAbajoS

@export var txt : String:
	set(value):
		txt = value
		$Label/Panel/RichTextLabel.text = txt

@export var EmotionsSpriteFrames: SpriteFrames:
	set(value):
		EmotionsSpriteFrames = value
		$pivot/Arriba/pivotRot/Sprite2D/emociones.sprite_frames = EmotionsSpriteFrames

@onready var area2D = $Spot
@onready var anim = $AnimationPlayer
@onready var emotions = $pivot/Arriba/pivotRot/Sprite2D/emociones
@export var NumOfLayer : int
var panel = load("res://Scenes/Zona_Astronomia/panelMamushka.tscn")
@export var color : Color
@export_multiline var panelText : String
@export var offsetPanel : Vector2
var isInArea
var MamushkaController
@export var mamu : Node2D
var ismouse
var isAngry
@export var isUp : bool


func _ready():
	mamu.get_node("DragObject").isDraggin.connect(DraggingController)
	mamu.get_node("DragObject").mouse_realese.connect(RealeseController)
	area2D.area_entered.connect(MamushkaControllerEnter)
	area2D.area_exited.connect(MamushkaControllerExit)
	SetEmotion("idle")

func MamushkaControllerEnter(x):
	if inSplitAnim : return
	x.mouse_realese.connect(MouseRealese)
	isInArea = true
	anim.play("Open")
	MamushkaController = x.get_parent()
	SoundManager.play("MamushkaLayer", Colortxt + "Open")

func MamushkaControllerExit(x):
	if inSplitAnim : return
	x.mouse_realese.disconnect(MouseRealese)
	isInArea = false
	MamushkaController = null
	anim.play("Close")
	SoundManager.play("MamushkaLayer", Colortxt + "CloseEmpy")
	await anim.animation_finished
	if ismouse:
		anim.play("idle")

func MouseRealese():
	if MamushkaController != null: CheckRigthIsLayer(MamushkaController)

var inSplitAnim

func CheckRigthIsLayer(x) :
	x.z_index = -1
	x.OnSpot(false)
	x.NotDropInAir()
	if x.CheckRight() == NumOfLayer:
		anim.play("Close")
		SoundManager.play("MamushkaLayer", Colortxt + "CloseRight")
		await anim.animation_finished
		x.z_index = 0
		AddToMamushkaController(x)
	else: 
		inSplitAnim = true
		area2D.get_node("CollisionShape2D").disabled = true
		anim.play("Close")
		await anim.animation_finished
		var direc = get_viewport_rect().get_center() - global_position
		var target_angle = atan2(direc.y, direc.x)
		var angle_diff1 = abs(wrapf(target_angle - rotation, -PI, PI))
		var durationAngle = max(0.1, angle_diff1 / PI * 0.3)
		var tween = get_tree().create_tween()
		tween.tween_property(self,"rotation",atan2(direc.y, direc.x),durationAngle).set_ease(Tween.EASE_IN_OUT)
		x.visible = false
		await tween.finished
		x.get_node("DragObject").CancelDrag()
		SoundManager.play("MamushkaLayer", Colortxt + "CloseWrong")
		anim.play("spit")
		x.visible = true
		area2D.get_node("CollisionShape2D").disabled = false
		await anim.animation_finished
		x.z_index = 0
		var angle_diff = abs(rotation - initRot)
		var rotationDuration = max(0.1, angle_diff / PI * 0.3)
		var tween2 = get_tree().create_tween()
		tween2.tween_property(self,"rotation",initRot,rotationDuration).set_ease(Tween.EASE_IN_OUT)
		await tween2.finished
		$pivot/Arriba/pivotRot.rotation = 0
		$pivot/Abajo/pivotRot.rotation = 0
		x.OnSpot(true)
		isAngry = true
		inSplitAnim = false
		await get_tree().create_timer(2).timeout
		isAngry=false
		SetEmotion("idle")
		
	x.OnSpot(true)


func AddToMamushkaController(x):
	x.AddLayer()
	x.get_node("DragObject").CancelDrag()
	SpawnPanel()
	queue_free()

func AdjustRotationPivot():
	var spriteW = float(ParteArriba.get_width())
	var x = spriteW *0.7 - spriteW/2
	print(x)
	$pivot/Arriba/pivotRot.position.y = x
	$pivot/Arriba/pivotRot.position.x = -ParteArriba.get_height()/2
	$pivot/Arriba/pivotRot/Sprite2D.position = Vector2(ParteArriba.get_height()/2,-x)
	
func DraggingController():
	ismouse = true
	anim.play("idle")
	SetEmotion("idle")
	if isAngry:
		SetEmotion("angry", 1)

func RealeseController():
	ismouse = false
	if anim.current_animation == "idle":
		anim.pause()
		SetEmotion("idle")

func _process(delta):
	if !MamushkaController : return
	if MamushkaController.get_node("DragObject").AskSpot != area2D:
		MamushkaControllerExit(MamushkaController.get_node("DragObject"))
		area2D.area_exited.disconnect(MamushkaControllerExit)
		MamushkaController = null

func SpawnPanel():
	var instancePanel = panel.instantiate()
	get_parent().add_child(instancePanel)
	instancePanel.Connect(mamu)
	instancePanel.position = position + Vector2(-160,-160) + offsetPanel
	var newStylebox = instancePanel.get_theme_stylebox("panel").duplicate()
	newStylebox.bg_color = color
	instancePanel.add_theme_stylebox_override("panel", newStylebox)
	
	instancePanel.get_node("RichTextLabel").text = panelText 

func SetEmotion(emotion, time = 0):
	emotions.play(emotion)
	if emotion == "idle":
		await get_tree().create_timer(randf_range(7,10)).timeout
		if emotions.animation != "idle": return
		emotions.play("look")
		await emotions.animation_finished
		SetEmotion("idle")
	if time != 0:
		await get_tree().create_timer(time).timeout
		SetEmotion("idle")
