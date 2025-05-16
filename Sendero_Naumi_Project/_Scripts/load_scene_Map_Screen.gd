extends Control
@export var SceneToLoad : String
var path
@export var HoldChangeScene : bool 
var madeChangeScene = true

func _ready():
	path = "res://Scenes/" + SceneToLoad + ".tscn"
	if HoldChangeScene: madeChangeScene = false

func StartLoad():
	ResourceLoader.load_threaded_request(path)

func MakeChangeScene():
	madeChangeScene = true

func _process(delta):
	if !madeChangeScene:return
	var progress = []
	ResourceLoader.load_threaded_get_status(path,progress)
	
	if progress[0] == 1:
		var sceneToMove = ResourceLoader.load_threaded_get(path)
		get_tree().change_scene_to_packed(sceneToMove)
