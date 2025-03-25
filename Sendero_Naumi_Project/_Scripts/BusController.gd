extends Control



@onready var slider = $HSlider
@onready var label = $Label
@onready var label2 = $Label2
var VolumeSettingsInstance = VolumeSettings.new()
var busName 

func Init(_busName: String):
	load_file()
	busName = _busName
	label.text = _busName
	var volume = VolumeSettingsInstance.SlidersVulumeSettings[busName]
	slider.value = volume
	label2.text = str(volume)
	var bus = AudioServer.get_bus_index(busName)
	AudioServer.set_bus_volume_db(bus,volume)

func changeVolume(volumeValue : float):
	var bus = AudioServer.get_bus_index(busName)
	AudioServer.set_bus_volume_db(bus,volumeValue)
	label2.text = str(volumeValue)
	VolumeSettingsInstance.SlidersVulumeSettings[busName] = volumeValue
	save()

func load_file():
	VolumeSettingsInstance  = ResourceLoader.load("user://"  + "VolumeSettings.tres")
	
func save():
	ResourceSaver.save(VolumeSettingsInstance,"user://" + "VolumeSettings.tres")
