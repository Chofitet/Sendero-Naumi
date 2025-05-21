extends Control

var save_file_path = "user://"
var save_file_name_minigame = "MiniGameResource.tres"
var save_file_name_zone = "ZoneResource.tres"
var save_file_name_Instances = "InstanceResource.tres"
var save_file_name_Volume_Settings = "VolumeSettings.tres"
var minigameResourceFile = MiniGameResource.new()
var zoneResourceFile = ZoneResource.new()
var instanceResource = InstanceResource.new()
var volumeSettings = VolumeSettings.new()
signal StartCharge
signal ChargeNextLevel

func load_file(file, path):
	file  = ResourceLoader.load(save_file_path  + path)
	
func save(file, path):
	ResourceSaver.save(file,save_file_path+path)

var once = false

func _ready():
	if ResourceLoader.exists(save_file_path + save_file_name_minigame):
		chargeFiles()

func chargeFiles():
	if once: return
	once = true
	var timeToCharge = 3
	var all_saved = false
	if ResourceLoader.exists(save_file_path + save_file_name_minigame):
		load_file(minigameResourceFile,save_file_name_minigame)
	else:
		save(minigameResourceFile,save_file_name_minigame)
		timeToCharge = 8
		
	if ResourceLoader.exists(save_file_path + save_file_name_zone):
		load_file(zoneResourceFile,save_file_name_zone)
	else:
		save(zoneResourceFile,save_file_name_zone)
	if ResourceLoader.exists(save_file_path + save_file_name_Instances):
		load_file(instanceResource,save_file_name_Instances)
	else: 
		save(instanceResource,save_file_name_Instances)
	
	if ResourceLoader.exists(save_file_path + save_file_name_Volume_Settings):
		load_file(volumeSettings,save_file_name_Volume_Settings)
	else:
		save(volumeSettings,save_file_name_Volume_Settings)
	
	PlayerVariables.SetLastZoneBeforeQuit()
	CheckFirsPlayTime()
	
	StartCharge.emit(timeToCharge)

func CheckFirsPlayTime():
	
	minigameResourceFile = ResourceLoader.load("user://" + "MiniGameResource.tres")
	
	if minigameResourceFile.StateMinigames["noFirstTimePlay"]:
		get_node("ButtonChangeScene").preloadScene = "Map_Screen"
		get_node("ButtonChangeScene").NextScene = "Map_Screen"
		var f = get_node("ButtonChangeScene").preloadScene
