extends Control

@onready var area2d = $Area2D
@export var FirstInstance : Control

func _ready():
	area2d.area_entered.connect(HideTutorial)
	visible = false

func ShowTutorial():
	if FirstInstance.visible:
		visible = true

func HideTutorial(x):
	if x.is_in_group("topo"):
		visible = false
	
