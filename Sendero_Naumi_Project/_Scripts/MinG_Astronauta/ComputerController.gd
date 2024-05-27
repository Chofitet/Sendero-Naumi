extends Node2D
@onready var face = $faceAnim
@export var isPerspective : bool

func _ready():
	if !isPerspective:
		$faceAnim.sprite_frames = load("res://Resources/PC_Face_Astronauta/PC_Front.tres")
		$normal.visible = true
	else :
		$faceAnim.sprite_frames = load("res://Resources/PC_Face_Astronauta/PC_perspective.tres")
		$Perspectiva.visible = true

func Setface(anim):
	face.play(anim)
