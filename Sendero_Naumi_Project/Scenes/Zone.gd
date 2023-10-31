extends TextureRect

var save_file_path = "user://"
var save_file_name = "ZoneResource.tres"
var ZoneResourseFile = ZoneResource.new()

func load_file():
		ZoneResourseFile  = ResourceLoader.load(save_file_path  + save_file_name)

func  _ready():
	Set_Complete()

func in_Zone():
	if PlayerVariables.lastState == self.name:
		get_node("ZoomingZone").visible = true
	ShowMiniGamesButtons()

func back_Zone():
	get_node("ZoomingZone").visible = false

func Set_Complete():
	load_file()
	for z in ZoneResourseFile.StateZones.keys():
		if ZoneResourseFile.StateZones[self.name] == true:
			get_node("CompleteState").visible = true

func ShowMiniGamesButtons():
	for b in get_node("ZoomingZone/SubViewport/ZoomingZone").get_children():
		b.OnZone()
