extends Node2D
var isOnArea : bool

func _ready():
	$Area2D.area_entered.connect(OnArea)
	$Area2D.area_exited.connect(OutArea)

func OnArea(x):
	if !x.is_in_group("apple"): return
	isOnArea = true

func OutArea(x):
	if !x.is_in_group("apple"): return
	isOnArea = false
