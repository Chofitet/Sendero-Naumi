extends RigidBody2D
@onready var timer = $Timer
@onready var area2d = $Area2D
var inPit

func _ready():
	area2d.area_entered.connect(TriggerInFall)
	timer.timeout.connect(OffPhysics)

func Freeze():
	freeze = true

func UnFreeze():
	if inPit: return
	freeze = false

func TriggerInFall(x):
	if x.is_in_group("BreakingSmallTrigger"):
		timer.start()

func OffPhysics():
	Freeze()
	inPit = true

func vibing():
	$AnimationPlayer.play("vibing")
	var actualcolor = $Sprite2D.modulate
	$Sprite2D.modulate.v = actualcolor.v + 0.2 

func StartTimer():
	timer.start()
	

func ChangeMask():
	set_collision_mask(1)
