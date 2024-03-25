@tool
extends Node2D
@onready var initRot = rotation
@export var ParteArriba : Texture: 
	set(new_value):
		ParteArriba = new_value
		$pivot/Arriba/pivotRot/Sprite2D.texture = ParteArriba
		ScaleAnimatedFace()
		AdjustRotationPivot()

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
@onready var area2D = $Spot
@onready var anim = $AnimationPlayer
@export var NumOfLayer : int
var panel = load("res://Scenes/Zona_Astronomia/panelMamushka.tscn")
@export var color : Color
@export var panelText : String
@export var offsetPanel : Vector2
var isInArea
var MamushkaController
@export var mamu : Node2D
var ismouse


func _ready():
	mamu.get_node("DragObject").isDraggin.connect(DraggingController)
	mamu.get_node("DragObject").mouse_realese.connect(RealeseController)
	area2D.area_entered.connect(MamushkaControllerEnter)
	area2D.area_exited.connect(MamushkaControllerExit)

func MamushkaControllerEnter(x):
	x.mouse_realese.connect(MouseRealese)
	isInArea = true
	anim.play("Open")
	MamushkaController = x.get_parent()

func MamushkaControllerExit(x):
	x.mouse_realese.disconnect(MouseRealese)
	isInArea = false
	MamushkaController = null
	anim.play("Close")
	await anim.animation_finished
	if ismouse:
		anim.play("idle")

func MouseRealese():
	CheckRigthIsLayer(MamushkaController)

func CheckRigthIsLayer(x) :
	x.z_index = -1
	x.OnSpot(false)
	if x.CheckRight() == NumOfLayer:
		anim.play("Close")
		await anim.animation_finished
		x.z_index = 0
		AddToMamushkaController(x)
	else: 
		area2D.get_node("CollisionShape2D").disabled = true
		anim.play("Close")
		await anim.animation_finished
		var direc = get_viewport_rect().get_center() - global_position
		var tween = get_tree().create_tween()
		tween.tween_property(self,"rotation",atan2(direc.y, direc.x),0.2).set_ease(Tween.EASE_IN_OUT)
		#x.Rotate(atan2(direc.y, direc.x),0.2)
		x.visible = false
		await tween.finished
		x.get_node("DragObject").CancelDrag()
		anim.play("spit")
		#x.Rotate(0,0.2)
		x.visible = true
		area2D.get_node("CollisionShape2D").disabled = false
		await anim.animation_finished
		x.z_index = 0
		var tween2 = get_tree().create_tween()
		tween2.tween_property(self,"rotation",initRot,0.1).set_ease(Tween.EASE_IN_OUT)
		
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
	
func ScaleAnimatedFace():
	var animatedFace = $pivot/Arriba/pivotRot/emociones
	var scaleFactor = float(ParteArriba.get_width())/300
	animatedFace.scale = Vector2(scaleFactor,scaleFactor)

func DraggingController():
	ismouse= true
	anim.play("idle")

func RealeseController():
	ismouse = false
	if anim.current_animation == "idle":
		anim.pause()

func _process(delta):
	if !MamushkaController : return
	if MamushkaController.get_node("DragObject").AskSpot != area2D:
		print("fuera")
		MamushkaControllerExit(MamushkaController.get_node("DragObject"))
		area2D.area_exited.disconnect(MamushkaControllerExit)
		MamushkaController = null

func SpawnPanel():
	var instancePanel = panel.instantiate()
	get_parent().add_child(instancePanel)
	instancePanel.position = position + Vector2(-100,-100) + offsetPanel
	var newStylebox = instancePanel.get_theme_stylebox("panel").duplicate()
	newStylebox.bg_color = color
	instancePanel.add_theme_stylebox_override("panel", newStylebox)
	
	instancePanel.get_node("RichTextLabel").text = panelText
