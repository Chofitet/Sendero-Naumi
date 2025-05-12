extends Node2D
@onready var face = $faceAnim
@export var isPerspective : bool
var anim

func _ready():
	if !isPerspective:
		anim = $normal/AnimationPlayer
		$faceAnim.sprite_frames = load("res://Resources/PC_Face_Astronauta/PC_Front.tres")
		$normal.visible = true
	else :
		anim = $Perspectiva/AnimationPlayer
		$faceAnim.sprite_frames = load("res://Resources/PC_Face_Astronauta/PC_perspective.tres")
		$Perspectiva.visible = true

var auxTimer

func Setface(anim):
	face.play("idle")
	await face.animation_finished
	face.play(anim)
	if anim == "talk":
		#$SoundEmitter.PlayEvent("talk")
		if auxTimer != null:
			auxTimer.set_time_left(1.6)
		else:
			auxTimer = get_tree().create_timer(1.6)
		await auxTimer.timeout
		face.play("idle")

func SmileAnim():
	face.play("smile")
	

func IdleAnim():
	face.play("idle")

func SetTalkInfinity():
	#face.play("idle")
	#await face.animation_finished
	face.play("talk")
	#SoundManager.play("CHIPA","talk")

func PlayOnScreen():
	anim.play("on_screen")

	
