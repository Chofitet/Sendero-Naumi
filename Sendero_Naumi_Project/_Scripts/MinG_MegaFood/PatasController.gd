extends Control
@export var inx_animal: int
var animalsArray : =[]
@onready var anim = $AnimationPlayer
@onready var timer = $Timer
var isInGame

func _ready():
	timer.timeout.connect(PlayCallAnim)

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
	PlayEnterAnim()
	isInGame = true

func PlayEnterAnim():
	$Label.visible = false
	$pivot/Sprite2D.texture = null
	anim.play("enterAnim")
	animalsArray[inx_animal].play("idle")
	timer.start()

func PlayCallAnim():
	animalsArray[inx_animal].play("call")
	timer.wait_time = randf_range(3.5,5)
	timer.stop()

func PlayOutAnim(plate):
	if !isInGame : return
	#animalsArray[inx_animal].play("idle")
	anim.play_backwards("enterAnim")
	AddPlateAtPivot(plate)
	#$Label.visible = true
	await anim.animation_finished
	anim.play("RESET")
	isInGame = false

func BackToIdle():
	animalsArray[inx_animal].play("idle")
	timer.start()

func AddPlateAtPivot(plate):
	var _texture = plate.texture
	$pivot/Sprite2D.texture = _texture

