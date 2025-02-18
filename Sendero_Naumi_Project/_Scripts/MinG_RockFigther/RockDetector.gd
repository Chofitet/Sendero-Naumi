extends Area2D


func _ready():
	area_entered.connect(RockEnter)

func RockEnter(x):
	if x.is_in_group("rock"):
		x.get_parent().StartTimer()
