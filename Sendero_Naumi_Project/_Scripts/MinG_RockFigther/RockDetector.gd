extends Area2D


func _ready():
	area_entered.connect(RockEnter)

func RockEnter(x):
	if x.is_in_group("rock"):
		var rock = x.get_parent()
		rock.StartTimer()
