extends Sprite2D

func _on_btn_zone_pressed():
	get_node("../Camera2D").zoom_in(position - get_node("../Camera2D").position)
	get_node("In_Zone").visible = true;



