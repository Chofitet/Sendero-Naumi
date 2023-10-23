extends State
class_name MegafaunaZone
@export var label : Label
@export var Minigames := []
var i = 0
signal inZone
signal backZone
var once = true

@export var NextScene : String

var save_file_path = "user://"
var save_file_name = "MiniGameResource.tres"
var minigameResourseFile = MiniGameResource.new()
func load_file():
	minigameResourseFile  = ResourceLoader.load(save_file_path  + save_file_name)
func save():
	ResourceSaver.save(minigameResourseFile,save_file_path+save_file_name)

func Enter():
	PlayerVariables.SaveLastState(self.name)
	label.text = self.name
	inZone.emit()
	get_parent().get_node("ButtonBack").visible = true

func Exit():
	backZone.emit()

func CheckAllTrue():
	load_file()
	i=0
	for m in Minigames:
		if (minigameResourseFile.StateMinigames[get_node(m).name]) == false: 
			return
		else: i += 1
		
		if(i == len(Minigames)):
			var Zoneresource = ZoneResource.new()
			Zoneresource = ResourceLoader.load(save_file_path + "ZoneResource.tres")
			if !Zoneresource.StateZones[self.name]: once = false
			Zoneresource.StateZones[self.name] = true
			ResourceSaver.save(Zoneresource,save_file_path + "ZoneResource.tres")
			if !once: get_tree().change_scene_to_file("res://Scenes/"+ NextScene + ".tscn")
