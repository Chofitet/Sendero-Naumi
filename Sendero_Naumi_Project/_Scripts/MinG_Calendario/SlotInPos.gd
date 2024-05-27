extends Node2D
@onready var parent = get_parent()
@onready var calendar = get_parent().get_parent()
@onready var calendarpivot = get_parent().get_parent().get_parent()

func _process(delta):
	global_position = parent.global_position + (calendar.offset * (get_child(0).scale.x))
