extends Node
var save_file_path = "user://"
var save_file_name = "MiniGameResource.tres"
var minigameResourseFile = MiniGameResource.new()

func load_file():
	minigameResourseFile  = ResourceLoader.load(save_file_path  + save_file_name)

func save():
	ResourceSaver.save(minigameResourseFile,save_file_path+save_file_name)

func FirstPlay():
	load_file()
	minigameResourseFile.Set_State_Minigame("noFirstTimePlay")
	minigameResourseFile.Set_FirstTimeInMap(true)
	save()
