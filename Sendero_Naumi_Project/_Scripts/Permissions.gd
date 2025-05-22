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
@export var InstroScene: PackedScene
@export var DisclaimerScene: PackedScene
signal ChargeNextLevel

func load_file(file, path):
	file  = ResourceLoader.load(save_file_path  + path)
	
func save(file, path):
	ResourceSaver.save(file,save_file_path+path)


func _ready():
	if ResourceLoader.exists(save_file_path + save_file_name_minigame):
		#Files allready exist
		chargeFiles()
		if CheckFirsPlayTime():
			GoToDisclaimer()
		else:
			GoToIntroScene()
	else:
		#Files need to be created
		chargeFiles()
		StartCharge()
	

func chargeFiles():
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
	
	if ResourceLoader.exists(save_file_path + save_file_name_Volume_Settings):
		load_file(volumeSettings,save_file_name_Volume_Settings)
	else:
		save(volumeSettings,save_file_name_Volume_Settings)
	
	PlayerVariables.SetLastZoneBeforeQuit()

func CheckFirsPlayTime() -> bool:
	minigameResourceFile = ResourceLoader.load("user://" + "MiniGameResource.tres")
	return minigameResourceFile.StateMinigames["noFirstTimePlay"]

func StartCharge():
	$BlackScreen.visible = false
	$ProgressBar/ProgressBar.StartLoad()

func GoToIntroScene():
	get_tree().change_scene_to_packed(InstroScene)

func GoToDisclaimer():
	get_tree().change_scene_to_packed(DisclaimerScene)
