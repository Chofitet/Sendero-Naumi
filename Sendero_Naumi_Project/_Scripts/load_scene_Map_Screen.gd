extends Control

var nextScene = "res://Scenes/Map_Screen.tscn"

func _ready():
	ResourceLoader.load_threaded_request(nextScene)

func _process(delta):
	var progress = []
	ResourceLoader.load_threaded_get_status(nextScene,progress)
	
	if progress[0] == 1:
		var sceneToMove = ResourceLoader.load_threaded_get(nextScene)
		get_tree().change_scene_to_packed(sceneToMove)
