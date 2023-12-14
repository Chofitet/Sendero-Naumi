extends Control
var sprite
var timer
var anim

func _ready():
	sprite = get_node("hand")
	timer = get_node("Timer")
	anim = get_node("hand/AnimationPlayer")
	timer.timeout.connect(StartAnim)

func SetVisibility(x):
	if x:
		timer.start()
	else:
		timer.timeout.disconnect(StartAnim)
		visible = false
		anim.play("RESET")

func StartAnim():
	visible = true
	anim.play("start_anim")

func IdleAnim():
	anim.play("idle_anim")
