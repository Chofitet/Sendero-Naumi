extends Node2D
var state = 0 
var SpriteLayers :=[]
@export var Outro : Control
@onready var anim = $AnimationPlayer
signal ToFinal

func _ready():
	anim.play("idle")
	$ButtonFinal.pressed.connect(FinalState)
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
	if state == 4:
		$ButtonFinal.visible = true

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

func FinalState():
	ToFinal.emit()
	$DragObject.mouse_realese.disconnect(MouseRealese)
	anim.play("to_final")
	z_index = 1
	rotation = 0
	await anim.animation_finished
	anim.play(("opacity"))
	Outro.visible = true
	Outro.get_node("AnimationPlayer").Play()
