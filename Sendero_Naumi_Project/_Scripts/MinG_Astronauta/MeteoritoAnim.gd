extends Node2D


func _ready():
	$Area2D.area_entered.connect(PlayAnim)

func PlayAnim(x):
	print(x.get_groups())
	if x.is_in_group("Player"):
		$AnimationPlayer.play("start")
