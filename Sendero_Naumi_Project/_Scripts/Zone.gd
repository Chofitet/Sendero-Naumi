extends TextureRect

var save_file_path = "user://"
var save_file_name = "ZoneResource.tres"
var ZoneResourseFile = ZoneResource.new()

func load_file():
		ZoneResourseFile  = ResourceLoader.load(save_file_path  + save_file_name)

func  _ready():
	Set_Complete()

func Set_Complete():
	load_file()
	for z in ZoneResourseFile.StateZones.keys():
		if ZoneResourseFile.StateZones[self.name] == true:
			$TextureRect/check.visible = true
