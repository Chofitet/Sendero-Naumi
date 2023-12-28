extends Node2D

func UnfrezeeAll():
	for p in get_children():
		if p.has_method("UnFreeze"):
			p.call_deferred("UnFreeze")

func Freeze():
	for p in get_children():
		if p.has_method("Freeze"):
			p.call_deferred("Freeze")
