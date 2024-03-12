extends Node2D

@onready var parent = get_parent()
@export var RotateTo : float
@export var timeToRotate: float
signal FinishRotate


func RotateParent():
	var tween = get_tree().create_tween()
	tween.tween_property(parent,"rotation",deg_to_rad(RotateTo),timeToRotate).set_ease(Tween.EASE_IN_OUT)
	await  tween.finished
	FinishRotate.emit()
	
