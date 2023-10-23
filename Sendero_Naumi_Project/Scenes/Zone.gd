extends TextureRect
class_name  Zone

var save_file_path = "user://"
var save_file_name = "ZoneResource.tres"
var ZoneResourseFile = ZoneResource.new()

func load_file():
		ZoneResourseFile  = ResourceLoader.load(save_file_path  + save_file_name)

func in_Zone():
	get_node("ZoomingZone").visible = true

func back_zone():
	get_node("ZoomingZone").visible = false

func Set_Complete():
	load_file()
	for z in ZoneResourseFile.StateZones.keys():
		if ZoneResourseFile.StateZones[self.name] == true:
			get_node("CompleteState").visible = true
