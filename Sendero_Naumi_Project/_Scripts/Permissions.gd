extends Control

var save_file_path = "user://"
var save_file_name_minigame = "MiniGameResource.tres"
var save_file_name_zone = "ZoneResource.tres"
var minigameResourseFile = MiniGameResource.new()
var zoneResourseFile = ZoneResource.new()

func load_file(file, path):
	file  = ResourceLoader.load(save_file_path  + path)
	
func save(file, path):
	ResourceSaver.save(file,save_file_path+path)

func _ready():
	if ResourceLoader.exists(save_file_path + save_file_name_minigame):
		load_file(minigameResourseFile,save_file_name_minigame)
	else:
		save(minigameResourseFile,save_file_name_minigame)
	if ResourceLoader.exists(save_file_path + save_file_name_zone):
		load_file(zoneResourseFile,save_file_name_zone)
	else:
		save(zoneResourseFile,save_file_name_zone)
	
