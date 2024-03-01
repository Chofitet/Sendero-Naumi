extends Node2D

@onready var parent = get_parent()
@export var ScaleTo : Vector2
@export var timeToScale : float
signal FinishScale


func ScaleParent():
	var tween = get_tree().create_tween()
	tween.tween_property(parent,"scale",ScaleTo,timeToScale).set_ease(Tween.EASE_IN_OUT)
	await  tween.finished
	FinishScale.emit()
