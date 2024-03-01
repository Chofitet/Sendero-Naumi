extends Control
var objControllers :=[]
@export var Instances :=[]
var i = 0

func _ready():
	for c in get_children():
		objControllers.append(c)
		c.visible = false

func Active():
	objControllers[i].visible = true
	i = i + 1

func OnButton():
	get_node(Instances[i - 1]).visible = false
