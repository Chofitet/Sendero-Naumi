extends Node2D

func Freeze():
	for p in get_children():
		p.freeze = true
