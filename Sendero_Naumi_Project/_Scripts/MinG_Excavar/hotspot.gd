extends Area2D
class_name hotspotScript
var isTrue : bool
@export var group : String

func _ready():
	isTrue = false
	area_entered.connect(TopoEnter)

func TopoEnter(x):
	if !x.is_in_group(group): return
	isTrue = true
	get_parent().checkHotSpots()
