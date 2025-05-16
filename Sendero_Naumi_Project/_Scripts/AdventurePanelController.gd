extends Control

var save_file_path = "user://"
var save_file_name = "MiniGameResource.tres"
var minigameResourseFile = MiniGameResource.new()
signal ShowPanel

func load_file():
	minigameResourseFile  = ResourceLoader.load(save_file_path  + save_file_name)

func save():
	ResourceSaver.save(minigameResourseFile,save_file_path  + save_file_name)

func _ready():
	load_file()
	if minigameResourseFile.StateMinigames["FirstTimeInMap"]:
		get_parent().visible = true
		ShowPanel.emit()
		
		
	minigameResourseFile.Set_FirstTimeInMap(false)
	save()
	await get_tree().create_timer(0.1).timeout
	$PanelSuerte/labelRich.visible_ratio = 1
