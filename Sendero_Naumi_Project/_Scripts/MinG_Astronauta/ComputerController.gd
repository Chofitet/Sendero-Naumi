extends Node2D
@onready var face = $faceAnim

func Setface(anim):
	face.play(anim)
