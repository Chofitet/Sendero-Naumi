extends AnimationPlayer
@export var animation : String
@export var DestroyInFinish : String
@export var AnimationsOrder : Array[String] 
var index = 0

func _ready():
	animation_finished.connect(DestroyAnimInFinishAnim)
	if AnimationsOrder.size() != 0:
		animation_finished.connect(PlayNextAnim)

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

func PlayNextAnim(x):
	if index >= AnimationsOrder.size() : return
	play(AnimationsOrder[index])
	index += 1

func SkipActualAnim():
	if index >= AnimationsOrder.size() : return
	stop()
	play(AnimationsOrder[index])
	index += 1
