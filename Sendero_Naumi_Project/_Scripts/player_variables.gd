extends Node

signal InactivePause
signal ActivePause
var NaumiLevel : int
var MinigameStage = 1
var lastState = "NoZone"
var ToLevelNaumi = false
var NumPiso = 0
var DebugMode = false
var NaumiDebugNum : float = 0

var save_file_path = "user://"
var save_file_name = "MiniGameResource.tres"
var zoneResource = ZoneResource.new()
var minigameResourseFile = MiniGameResource.new()

func IncreaseNaumiLevel():
	NaumiLevel += 1

func IncreaseMinigameStage():
	MinigameStage += 1

func SaveLastState(state):
	load_file()
	if lastState != "NoZone": 
		SaveLastPiso()
	lastState = state
	minigameResourseFile.Set_Zone(state)
	save()

func SetLastZoneBeforeQuit():
	load_file()
	if minigameResourseFile.StateMinigames["ToLevelNaumi"]:
		lastState = minigameResourseFile.Get_Zone()

func load_file():
	minigameResourseFile  = ResourceLoader.load(save_file_path  + save_file_name)

func save():
	ResourceSaver.save(minigameResourseFile,save_file_path+save_file_name)

func SetNaumiEvolve():
	minigameResourseFile.ToLevelNaumiFalse()
	SaveLastState("NoZone")

func SaveLastPiso(num = 5):
	
	if num != 5:
		NumPiso = num
		return
	
	load_file()
	var x = minigameResourseFile.Get_Zone()
	match x:
		"MegafaunaZone": 
			NumPiso = 1
		"AstronomiaZone": 
			NumPiso = 2
		"GeologiaZone": 
			NumPiso = 2
		"NoZone":
			NumPiso = 1

func EmitInactivePause():
	InactivePause.emit()
	
func EmitActivePause():
	ActivePause.emit()

func SetDebugMode(x):
	DebugMode = x

func SetNaumiDebugNum(x:float):
	NaumiDebugNum = x

func GetNaumiState() -> int:
	var num = 0
	zoneResource = ResourceLoader.load(save_file_path + "ZoneResource.tres")
	for z in zoneResource.StateZones.keys():
		if zoneResource.StateZones[z]:
			if not "Unlocked" in z: num += 1
	return num
