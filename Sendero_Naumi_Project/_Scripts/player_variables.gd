extends Node

var NaumiLevel : int
var MinigameStage = 1
var lastState = "NoZone"
var ToLevelNaumi = false

var save_file_path = "user://"
var save_file_name = "MiniGameResource.tres"
var minigameResourseFile = MiniGameResource.new()

func IncreaseNaumiLevel():
	NaumiLevel += 1

func IncreaseMinigameStage():
	MinigameStage += 1

func SaveLastState(state):
	load_file()
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
