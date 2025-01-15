extends Sprite2D

var save_file_path = "user://"
var save_file_name = "ZoneResource.tres"
var ZoneResourseFile = ZoneResource.new()

@export var ZonesForTriggerUnlock: Array[String] = []


func load_file():
		ZoneResourseFile  = ResourceLoader.load(save_file_path  + save_file_name)
		

func _ready():
	visible = false
	CheckCompletedZone()

func CheckCompletedZone():
	
	load_file()
	
	if ZonesForTriggerUnlock.size() == 0: return
	for z in ZonesForTriggerUnlock:

		if ZoneResourseFile.StateZones[z] == false:
			return
	
	visible = true
