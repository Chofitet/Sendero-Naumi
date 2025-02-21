@tool
extends Control

@export var refreshScreen : bool:
	set(value):
		resizeScreen()

func _ready():
	resizeScreen()

func resizeScreen():
	var screen_size = Vector2(get_viewport_rect().size.x,get_viewport_rect().size.y)
	set_size(screen_size)
	position = -1 * screen_size/2
