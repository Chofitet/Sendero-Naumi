extends Sprite2D

var currentState = 0

var NaumiStates = [load("res://Sprites/Naumi/Naumi_0.png"),
load("res://Sprites/Naumi/Naumi_1.png"),
load("res://Sprites/Naumi/Naumi_02.png")]
var save_file_path = "user://"
var save_file_name_Zone = "ZoneResource.tres"
var zoneResource = ZoneResource.new()

func load_file():
	zoneResource  = ResourceLoader.load(save_file_path  + save_file_name_Zone)

func _ready():
	load_file()
	for z in zoneResource.StateZones.keys():
		if zoneResource.StateZones[z]:
			currentState += 1
	texture = NaumiStates[currentState]
