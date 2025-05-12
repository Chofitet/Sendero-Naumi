extends Node

@export var BusName : String
var isFadeVolume
var bus

func _ready():
	bus = AudioServer.get_bus_index(BusName)

func SetVolume(volume_level: float, timeToSet : float =1):
	var tween = get_tree().create_tween()
	var current_volume = AudioServer.get_bus_volume_db(bus)
	tween.tween_method(set_bus_volume, current_volume, volume_level, timeToSet)

func set_bus_volume(value: float):
	AudioServer.set_bus_volume_db(bus, value)
