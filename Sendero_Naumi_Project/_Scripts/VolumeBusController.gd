extends Node

@export var BusName : String
var isFadeVolume
var bus

func _ready():
	bus = AudioServer.get_bus_index(BusName)

func SetVolume(volume_level: float):
	var tween = get_tree().create_tween()
	var current_volume = AudioServer.get_bus_volume_db(bus)
	tween.tween_method(set_bus_volume, current_volume, volume_level, 1.0)

func set_bus_volume(value: float):
	AudioServer.set_bus_volume_db(bus, value)
