extends Area2D
class_name hotspotScript
var isTrue : bool

func _ready():
	isTrue = false
	area_entered.connect(TopoEnter)

func TopoEnter(x):
	isTrue = true
	get_parent().checkHotSpots()
