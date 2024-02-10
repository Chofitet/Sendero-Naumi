extends Control
@export var inx_animal: int
var animalsArray : =[]
@onready var anim = $AnimationPlayer
@onready var timer = $Timer
var isInGame
signal Taken
var AnimResultFinish = false
var stopCall

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
	PlayEnterAnim()
	isInGame = true
	
	$papel.visible = false
	$pivot/bandeja.visible = true

func PlayEnterAnim():
	anim.play("enterAnim")
	animalsArray[inx_animal].play("idle")
	timer.timeout.connect(PlayCallAnim)
	timer.start()

func PlayCallAnim():
	if stopCall: return
	animalsArray[inx_animal].play("call")
	timer.wait_time = randf_range(4.5,5)
	timer.stop()

func PlayOutAnim(plate):
	if !isInGame : return
	animalsArray[inx_animal].play("idle")
	timer.timeout.disconnect(PlayCallAnim)
	anim.play_backwards("enterAnim")
	AddPlateAtPivot(plate)
	await anim.animation_finished
	anim.play("RESET")
	isInGame = false
	if inx_animal == 0: return
	ResultAnim()

func BackToIdle():
	animalsArray[inx_animal].play("idle")
	timer.start()

func ResultAnim():
	animalsArray[inx_animal].play("result")
	$papel.visible = true
	$pivot/bandeja.visible = false
	$pivot/Sprite2D.texture = null
	anim.play("result")
	await  anim.animation_finished
	AnimResultFinish = true
	

func AddPlateAtPivot(plate):
	if plate is String:
		$pivot/Sprite2D.texture = null
		return
	var _texture = plate.texture
	$pivot/Sprite2D.texture = _texture

func PlayTakeAnim():
	if !AnimResultFinish : return
	anim.play("take")
	AnimResultFinish = false
	await  anim.animation_finished
	get_parent().SetResultEvent()
	
