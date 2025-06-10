extends AnimationPlayer
@export var animation : String
@export var DestroyInFinish : String
@export var AnimationsOrder : Array[String] 
@export var preloadAnim : String
@export var GroupOfCollision : String
var index = 0

func _ready():
	animation_finished.connect(DestroyAnimInFinishAnim)
	if AnimationsOrder.size() != 0:
		animation_finished.connect(PlayNextAnim)
	
	AnimationPreCarga()

func Play():
	if animation == null or animation == "": return
	print("animation" + str(animation))
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

func AnimationPreCarga():
	if preloadAnim == "": return
	play(preloadAnim)
	seek(current_animation_length, true)
	stop()

func PlayFromCollision(x, anim):
	if x.is_in_group(GroupOfCollision): play(anim)
