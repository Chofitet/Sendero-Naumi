extends AnimationPlayer
@export var animation : String

func Play():
	play(animation)
	pass

func  PlayAnim(anim):
	play(anim)
	var a = anim
	pass

func Stop():
	stop()

func Reset():
	play("RESET")
