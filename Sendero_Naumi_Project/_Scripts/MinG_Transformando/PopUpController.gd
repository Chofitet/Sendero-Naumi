extends Control
var viewportPopUp

func _ready():
	get_node("ColorRect/Button").pressed.connect(disablePopUp)
	viewportPopUp = get_parent().get_parent()
	viewportPopUp.visible = false
	visible = false


func activePopUp():
	viewportPopUp.visible = true
	visible = true

func disablePopUp():
	viewportPopUp.visible = false
	visible = false
