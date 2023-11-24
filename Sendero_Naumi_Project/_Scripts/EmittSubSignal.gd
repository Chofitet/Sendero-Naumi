extends Node2D
signal trigger

func _ready():
	get_node("pivot/Button").pressed.connect(isPressed)

func isPressed():
	trigger.emit()
