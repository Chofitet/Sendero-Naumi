extends Node
var save_file_path = "user://"
var save_file_name = "MiniGameResource.tres"

var minigameResourseFile = MiniGameResource.new()

func _ready():
	Verify_Directory(save_file_path)

func Verify_Directory(path : String):
	DirAccess.make_dir_absolute(path)
	
func save():
	ResourceSaver.save(minigameResourseFile , save_file_path + save_file_name)

func load_file():
	minigameResourseFile  = ResourceLoader.load(save_file_path  + save_file_name)

func Set_Complete():
	load_file()
	minigameResourseFile.Set_State_Minigame(self.name)
	minigameResourseFile.Set_Last_Minigame(self.name)
	save()
	
