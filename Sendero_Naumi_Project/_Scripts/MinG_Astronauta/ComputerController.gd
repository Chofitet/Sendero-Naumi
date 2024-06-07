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

func Setface(anim):
	face.play(anim)
	if anim == "talk":
		await get_tree().create_timer(3).timeout
		face.play("idle")

func PlayOnScreen():
	anim.play("on_screen")
