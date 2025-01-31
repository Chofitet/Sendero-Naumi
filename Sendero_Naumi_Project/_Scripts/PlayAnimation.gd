extends AnimationPlayer
@export var animation : String
@export var DestroyInFinish : String


func _ready():
	animation_finished.connect(DestroyAnimInFinishAnim)

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

func DestroyAnimInFinishAnim(x):
	if x == DestroyInFinish:
		queue_free()


