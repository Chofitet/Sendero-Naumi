extends Node2D

func _ready():
	visible = false

func _on_btn_zone_pressed():
	visible = true


func _on_btn_back_pressed():
	get_node("../../Camera2D").zoom_out(Vector2(0, 0))
	visible = false

