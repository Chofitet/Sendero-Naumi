extends Node2D
signal trigger
signal endAnim

func _ready():
	get_node("pivot/Button").pressed.connect(isPressed)

func isPressed():
	trigger.emit()

func StartAnim():
	get_node("AnimationMove").play("map_move")

func EndAnim(x):
	endAnim.emit()

