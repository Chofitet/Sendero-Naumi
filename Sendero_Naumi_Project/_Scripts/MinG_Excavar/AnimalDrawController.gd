extends Node2D

@export var _name : String
@onready var anim = $AnimationPlayer


func StartFadeBone():
	anim.play("FadeBones")

func StartFadeLive():
	anim.play("FadeLive")

func PlayCompleted():
	anim.play("completed")

