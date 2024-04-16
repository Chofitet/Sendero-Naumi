extends Node2D
var state = 0 
var SpriteLayers :=[]
@onready var anim = $AnimationPlayer

func _ready():
	anim.play("idle")
	$DragObject.isDraggin.connect(InDraggin)
	$DragObject.mouse_realese.connect(MouseRealese)
	$DragObject.lastPosition = position
	for l in $Sprites.get_children():
		SpriteLayers.append(l)
		l.visible = false
		SpriteLayers[0].visible = true

func AddLayer():
	state += 1
	SpriteLayers[state].visible = true

func CheckRight() -> int:
	return state

func OnSpot(x):
	$DragObject.isEnableButton(x)

func Rotate(rot = 0, time = 0):
	var tween = get_tree().create_tween()
	tween.tween_property(self,"rotation",rot,time)

func InDraggin():
	anim.pause()

func MouseRealese():
	anim.play("idle")

func PlayAnimTitulo():
	$Sprites/Layer0/titulo/AnimationPlayer.play("titulo_anim")
