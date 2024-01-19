extends Node2D

var pick_up = false
var Sprite 
var is_in_spot = false
var initial_spot
var isInPosition
@export var spot : Area2D

func _ready():
	Sprite = get_node("Object")
	initial_spot = Sprite.position
signal mouse_realese

func _process(delta):
	if pick_up == true:
		Sprite.global_position = get_global_mouse_position()
	if Input.is_action_just_released("TouchScreen"):
		mouse_realese.emit()
	
func _on_button_pressed():
	pick_up = true
	await  mouse_realese
	pick_up = false
	if (is_in_spot):
		Sprite.position = spot.position
		isInPosition = true
	else: 
		Sprite.position = initial_spot
		isInPosition = false
	get_parent().check_if_all_true()

func _on_area_2d_area_entered(area):
	is_in_spot = true

func _on_area_2d_area_exited(area):
	is_in_spot = false
