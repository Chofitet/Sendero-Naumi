extends Control

@onready var menu = $CanvasLayer
@export var AudioBuses : Array[String] = []
var instanceBusSlider = preload("res://Scenes/Experiments/bus_controller.tscn")
@onready var vConteiner = $CanvasLayer/Control/ColorRect/ScrollContainer/MarginContainer/VBoxContainer
var menuAppear = false

func _ready():
	createSliders()
	menu.visible = false

func AppearMenu():
	if !menuAppear:
		menu.visible = true
	else:  menu.visible = false
	
	menuAppear = !menuAppear

func createSliders():
	for ab in AudioBuses:
		var instance = instanceBusSlider.instantiate()
		vConteiner.add_child(instance)
		instance.Init(ab)
