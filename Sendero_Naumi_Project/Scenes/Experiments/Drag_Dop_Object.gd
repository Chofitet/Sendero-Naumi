extends Node2D

var pick_up = false
var Sprite 
var is_in_spot = false
var initial_spot

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
		Sprite.position = get_node("Spot").position
	else: Sprite.position = initial_spot

func _on_area_2d_area_entered(area):
	is_in_spot = true
	print("collision_enter")

func _on_area_2d_area_exited(area):
	is_in_spot = false
	print("collision_exit")
