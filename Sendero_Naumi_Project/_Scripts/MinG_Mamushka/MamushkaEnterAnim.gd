extends Node2D
@export var initPos : Marker2D


func DoAnim():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position", initPos.position, 1).set_trans(Tween.TRANS_SPRING)
