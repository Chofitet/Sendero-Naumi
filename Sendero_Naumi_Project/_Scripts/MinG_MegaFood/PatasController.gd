extends Control
@export var inx_animal: int
var animalsArray : =[]
@onready var anim = $AnimationPlayer
@onready var timer = $Timer
@onready var pataSuelta = $pivot/PataSuelta
@onready var buttonTouchAnimal = $pivot/Button
@export var SpritesPatasDer : =[]
@export var Panels : Array[Panel]
var isInGame
var AnimResultFinish = false
var stopCall
signal StartComand
signal EndComand
signal StartTutorial
signal ReorganizePlates

func _ready():
	for f in get_parent().get_node("HBoxContainer").get_children():
		f.get_node("DragObject").isDraggin.connect(StopCallAnim.bind(true))
	get_parent().get_node("HBoxContainer").RealeaseDragObject.connect(StopCallAnim.bind(false))
	buttonTouchAnimal.pressed.connect(PlayCallAnim)

func SetAnimalInstance(x):
	inx_animal = x
	for a in $pivot.get_children():
		if a is AnimatedSprite2D:
			animalsArray.append(a)
			a.visible = false
	animalsArray[inx_animal].play("idle")
	animalsArray[inx_animal].visible = true
	animalsArray[inx_animal].animation_finished.connect(BackToIdle)
	anim.play("RESET")
	timer.wait_time = 1
	isInGame = true
	CommandAppear()
	$papel.visible = false
	$pivot/bandeja.visible = true

func PlayEnterAnim():
	buttonTouchAnimal.visible = false
	timer.timeout.connect(PlayCallAnim)
	timer.start()
	animalsArray[inx_animal].play("idle")
	anim.play("enterAnim")

func PlayCallAnim():
	if stopCall: return
	buttonTouchAnimal.visible = false
	animalsArray[inx_animal].play("call")
	timer.wait_time = randf_range(4.5,5)
	timer.stop()

func StopCallAnim(x):
	stopCall = x

func PlayOutAnim():
	if !isInGame : return
	buttonTouchAnimal.visible = false
	animalsArray[inx_animal].play("idle")
	timer.timeout.disconnect(PlayCallAnim)
	anim.play_backwards("enterAnim")
	await anim.animation_finished
	anim.play("RESET")
	isInGame = false
	ResultAnim()

func BackToIdle():
	buttonTouchAnimal.visible = true
	animalsArray[inx_animal].play("idle")
	timer.start()

func WrongAns():
	buttonTouchAnimal.visible = false
	pataSuelta.visible = true
	animalsArray[inx_animal].self_modulate = Color(0,0,0,0)
	animalsArray[inx_animal].get_node("pata").visible = true
	pataSuelta.get_child(0).texture = SpritesPatasDer[inx_animal]
	anim.play("WrongAnim")
	await anim.animation_finished
	anim.play("AngryAnim")
	await anim.animation_finished
	RestartAfterWrong()

func RestartAfterWrong():
	ReorganizePlates.emit()
	$pivot/plate.texture = null
	BackToIdle()
	animalsArray[inx_animal].self_modulate = Color(1,1,1,1)
	pataSuelta.visible = false
	animalsArray[inx_animal].get_node("pata").visible = false

func ResultAnim():
	animalsArray[inx_animal].play("result")
	$papel.visible = true
	$pivot/bandeja.visible = false
	$pivot/plate.texture = null
	anim.play("result")
	await  get_tree().create_timer(0.8).timeout
	AnimResultFinish = true


func AddPlateAtPivot(plate):
	if plate is String:
		$pivot/plate.texture = null
		return
	var _texture = plate.texture
	$pivot/plate.texture = _texture

func PlayTakeAnim():
	if !AnimResultFinish : return
	var animPaper = $AnimPaper
	animPaper.play("take")
	AnimResultFinish = false
	await  animPaper.animation_finished
	get_parent().SetResultEvent()
	
func CommandAppear():
	StartComand.emit()
	if inx_animal == 0:
		istutorial = true
		Panels[inx_animal].EnterPanel()
	else:
		istutorial = false
		Panels[inx_animal].EnterPanel()

var istutorial

func passNextInstance():
	PlayEnterAnim()
	EndComand.emit()
	if istutorial:
		StartTutorial.emit()
