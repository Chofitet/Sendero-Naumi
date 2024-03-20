@tool
extends Node2D

@export var ParteArriba : Texture: 
	set(new_value):
		ParteArriba = new_value
		$Arriba/pivotRot/Sprite2D.texture = ParteArriba
		

@export var ParteAbajo : Texture:
	set(new_value):
			ParteAbajo = new_value
			$Abajo/pivotRot/Sprite2D.texture = ParteAbajo

@onready var area2D = $Spot
@onready var anim = $AnimationPlayer
@export var NumOfLayer : int
var isInArea
var MamushkaController


func _ready():
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

func MouseRealese():
	CheckRigthIsLayer(MamushkaController)

func CheckRigthIsLayer(x) :
	x.z_index = -1
	if x.CheckRight() == NumOfLayer:
		anim.play("Close")
		await anim.animation_finished
		AddToMamushkaController(x)
	else: 
		area2D.get_node("CollisionShape2D").disabled = true
		anim.play("Close")
		await anim.animation_finished
		x.get_node("DragObject").CancelDrag()
		anim.play("spit")
		x.z_index = 0
		await get_tree().create_timer(1).timeout
		area2D.get_node("CollisionShape2D").disabled = false

func AddToMamushkaController(x):
	x.AddLayer()
	x.get_node("DragObject").CancelDrag()
	queue_free()
	#al terminar animación close aumenta en 1 el state controller y se autodestruye

func _process(delta):
	if !MamushkaController : return
	if MamushkaController.get_node("DragObject").AskSpot != area2D:
		print("fuera")
		MamushkaControllerExit(MamushkaController.get_node("DragObject"))
		area2D.area_exited.disconnect(MamushkaControllerExit)
		MamushkaController = null
