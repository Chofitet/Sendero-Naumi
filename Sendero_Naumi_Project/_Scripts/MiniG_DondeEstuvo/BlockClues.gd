extends Node2D
@export var overlay: ColorRect
signal startAnim
signal finalAnim

func BlockOthersClues(x, boleean):
	for c in get_children():
		if c != x:
			c.BlockButton(boleean)
			print(c.name)
			if c.inPlace: continue
			c.SetSquiggling(boleean)

	if boleean:
		Overlay(false)
	else:
		Overlay(true)

func Overlay(x):
	overlay.visible = x

func StartAnim():
	startAnim.emit()

func FinalAnim():
	finalAnim.emit()
