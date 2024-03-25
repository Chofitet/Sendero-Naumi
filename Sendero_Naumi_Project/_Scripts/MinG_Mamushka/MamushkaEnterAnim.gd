extends Node2D
@export var initPos : Marker2D

func _ready():
	get_parent().get_parent().Intro4.connect(DoAnim)

func DoAnim():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position", initPos.position, 1).set_trans(Tween.TRANS_SPRING)
