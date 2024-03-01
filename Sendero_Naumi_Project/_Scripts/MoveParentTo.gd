extends Node2D

@onready var parent = get_parent()
@export var PointToMove : Marker2D
@export var timeTomove : float
signal FinishMove

func MoveParent():
	var tween = get_tree().create_tween()
	tween.tween_property(parent,"global_position",PointToMove.global_position,timeTomove).set_ease(Tween.EASE_IN_OUT)
	await  tween.finished
	FinishMove.emit()
