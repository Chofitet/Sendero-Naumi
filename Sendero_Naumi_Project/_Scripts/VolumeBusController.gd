extends Node

@export var BusName : String
var isFadeVolume
var bus
var volume_tween: Tween

func _ready():
	bus = AudioServer.get_bus_index(BusName)
	tree_exiting.connect(_exit_tree)

func SetVolume(volume_level: float, timeToSet : float = 1):
	if volume_tween and volume_tween.is_valid():
		volume_tween.kill()

	var current_volume = AudioServer.get_bus_volume_db(bus)
	volume_tween = get_tree().create_tween()
	volume_tween.tween_method(set_bus_volume, current_volume, volume_level, timeToSet)

func set_bus_volume(value: float):
	if is_inside_tree() and AudioServer.bus_count > bus:
		AudioServer.set_bus_volume_db(bus, value)

func _exit_tree():
		volume_tween.kill()
