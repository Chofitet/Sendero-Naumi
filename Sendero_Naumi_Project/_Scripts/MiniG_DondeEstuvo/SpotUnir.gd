extends TextureRect
var lastEnter

func _ready():
	$Area2D.area_entered.connect(CheckUnion)
	$Area2D.area_exited.connect(Exit)

func CheckUnion(x):
	if !x.is_in_group("item") : return
	if lastEnter == null:
		lastEnter = x
	elif lastEnter != null and x != lastEnter:
		lastEnter.get_parent().resetAll()
		lastEnter = x
	get_parent().checkUnions()

func Exit(x):
	print(x.get_parent().name)
	print(name)
	if x == lastEnter:
		lastEnter = null
		get_parent().checkUnions()
