extends RigidBody2D

func _ready():
	$Area2D.area_entered.connect(AreaEnter)
	for p in $BreakingRock.get_children():
		p.get_node("CollisionShape2D").disabled = true

func AreaEnter(x):
	if x.is_in_group("BreakingSmallTrigger"):
		ShowSmallsPiceRocks()

func ShowSmallsPiceRocks():
	var parent = $BreakingRock
	for p in parent.get_children():
		p.visible = true
		p.call_deferred("set_modulate",modulate)
		p.get_node("CollisionShape2D").call_deferred("set_disabled", false)
		p.call_deferred("set_freeze_enabled",false)
		p.call_deferred("reparent",get_parent())
		
	queue_free()
