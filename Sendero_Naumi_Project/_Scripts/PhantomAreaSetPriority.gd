extends Area2D
@export var JustInEnter : bool
@export var JustOnce : bool

func _ready():
	area_entered.connect(AreaEnter)
	area_exited.connect(AreaExited)

func AreaEnter(x):
	if x.is_in_group("Player"):
		get_parent().set_priority(10)
		if JustOnce: queue_free()

func AreaExited(x):
	if JustInEnter: return
	if x.is_in_group("Player"):
		get_parent().set_priority(0)
