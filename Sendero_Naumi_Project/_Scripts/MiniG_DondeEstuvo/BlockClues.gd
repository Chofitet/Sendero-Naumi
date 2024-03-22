extends Node2D
@export var overlay: ColorRect

func BlockOthersClues(x, boleean):
	for c in get_children():
		if c != x:
			c.BlockButton(boleean)

	if boleean:
		Overlay(false)
	else:
		Overlay(true)

func Overlay(x):
	overlay.visible = x
