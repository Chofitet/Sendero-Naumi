extends Control

var save_file_path = "user://"
var save_file_name = "MiniGameResource.tres"
var minigameResourceFile = MiniGameResource.new()

func _ready():
	minigameResourceFile = ResourceLoader.load(save_file_path + save_file_name)
	if minigameResourceFile.StateMinigames["MarkAsPlayed"]:
		get_child(0).EnterAnim()
		minigameResourceFile.StateMinigames["noFirstTimePlay"] = false
		ResourceSaver.save(minigameResourceFile,save_file_path+save_file_name)
		
