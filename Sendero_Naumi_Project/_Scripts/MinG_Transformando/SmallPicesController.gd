extends RigidBody2D
@onready var timer = $Timer
@onready var area2d = $Area2D

func _ready():
	pass
	area2d.area_entered.connect(TriggerInFall)
	timer.timeout.connect(OffPhysics)

func Freeze():
	freeze = true

func UnFreeze():
	freeze = false

func TriggerInFall(x):
	if x.is_in_group("BreakingSmallTrigger"):
		timer.start()

func OffPhysics():
	Freeze()
	
