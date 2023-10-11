extends Node2D

@export var object_name : String

var pick_up = false
var is_in_spot = false
var initial_spot
var spot_position

func _ready():
	initial_spot = position
	
signal mouse_realese

func _process(delta):
	if pick_up == true:
		global_position = get_global_mouse_position()
	if Input.is_action_just_released("TouchScreen"):
		mouse_realese.emit()
	
func _on_button_pressed():
	pick_up = true
	await  mouse_realese
	pick_up = false
	get_parent().check_if_all_true()
	if (!is_in_spot):
		position = initial_spot
	else: position = spot_position


