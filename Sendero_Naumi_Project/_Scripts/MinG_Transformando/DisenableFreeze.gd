extends Node2D
@export var rockParent : Node2D

func UnfrezeeAll():
	for p in get_children():
		if p.has_method("UnFreeze"):
			p.call_deferred("UnFreeze")
			p.reparent(rockParent)

func Freeze():
	for p in get_children():
		if p.has_method("Freeze"):
			p.call_deferred("Freeze")

func setInstances(x):
	for c in get_children():
		c.SetInstances(x)
