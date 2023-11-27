extends AnimationPlayer
@export var animation : String

func Play():
	play(animation)

func  PlayAnim(anim):
	play(anim)

func Stop():
	stop()

func Reset():
	play("RESET")
