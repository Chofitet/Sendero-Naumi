extends Area2D

@export var spot_name : String
var isInPosition

func _on_area_entered(area):
	var object_ref = area.get_parent()
	object_ref.is_in_spot = true
	object_ref.spot_position = position
	if (object_ref.object_name == spot_name):
		isInPosition = true
	else : isInPosition = false
	object_ref.ref_spot = get_node("spot")

func _on_area_exited(area):
	var object_ref = area.get_parent()
	object_ref.is_in_spot = false
	if object_ref.pick_up == true :
		isInPosition = false

