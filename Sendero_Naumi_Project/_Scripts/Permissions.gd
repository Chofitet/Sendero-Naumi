extends Control

var save_file_path = "user://"
var save_file_name_minigame = "MiniGameResource.tres"
var save_file_name_zone = "ZoneResource.tres"
var save_file_name_Instances = "InstanceResource.tres"
var minigameResourceFile = MiniGameResource.new()
var zoneResourceFile = ZoneResource.new()
var instanceResource = InstanceResource.new()

func load_file(file, path):
	file  = ResourceLoader.load(save_file_path  + path)
	
func save(file, path):
	ResourceSaver.save(file,save_file_path+path)

func _ready():
	if ResourceLoader.exists(save_file_path + save_file_name_minigame):
		load_file(minigameResourceFile,save_file_name_minigame)
	else:
		save(minigameResourceFile,save_file_name_minigame)
	if ResourceLoader.exists(save_file_path + save_file_name_zone):
		load_file(zoneResourceFile,save_file_name_zone)
	else:
		save(zoneResourceFile,save_file_name_zone)
	if ResourceLoader.exists(save_file_path + save_file_name_Instances):
		load_file(instanceResource,save_file_name_Instances)
	else: 
		save(instanceResource,save_file_name_Instances)
	
	PlayerVariables.SetLastZoneBeforeQuit()
	CheckFirsPlayTime()

func CheckFirsPlayTime():
	
	minigameResourceFile = ResourceLoader.load("user://" + "MiniGameResource.tres")
	
	if minigameResourceFile.StateMinigames["noFirstTimePlay"]:
		get_node("SkipSceen").NextScene = "Map_Screen"
		var f = get_node("SkipSceen").NextScene
