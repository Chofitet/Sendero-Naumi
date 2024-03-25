extends TextureRect
var lastEnter
signal mouse_released
var isexit

func _ready():
	$Area2D.area_entered.connect(CheckUnion)
	$Area2D.area_exited.connect(Exit)

func _input(event):
	if Input.is_action_just_released("TouchScreen"):
		mouse_released.emit()

func CheckUnion(x):
	isexit = false
	if !x.is_in_group("item") : return
	if lastEnter == null:
		lastEnter = x
	elif lastEnter != null and x != lastEnter:
		await mouse_released
		if isexit: return
		lastEnter.get_parent().resetAll()
		lastEnter = x

func Exit(x):
	isexit = true
	if x == lastEnter:
		lastEnter = null

func Disconnect():
	$Area2D.queue_free()
