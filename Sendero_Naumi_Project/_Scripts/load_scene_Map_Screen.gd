extends Control
#@export var SceneToLoad : String
#var path
#@export var HoldChangeScene : bool 
#var madeChangeScene = true
#@export var haveProgressBar : bool
#var firstBarCharge = false

#func _ready():
#	path = "res://Scenes/" + SceneToLoad + ".tscn"
#	if HoldChangeScene: madeChangeScene = false
#
#func StartLoad():
#	ResourceLoader.load_threaded_request(path)
#
#func MakeChangeScene():
#	madeChangeScene = true
#	if haveProgressBar: 
#		$ProgressBar.visible = true
#		startChargeBar()
#
#func _process(delta):
#	if !madeChangeScene:return
#	var progress = []
#	ResourceLoader.load_threaded_get_status(path,progress)
#
#	if haveProgressBar and firstBarCharge:
#		$Label.text = str(progress[0])
#		if progress[0] > 0.3:
#			ChargeBar(progress[0])
#
#		return
#
#	if progress[0] == 1:
#		var sceneToMove = ResourceLoader.load_threaded_get(path)
#		get_tree().change_scene_to_packed(sceneToMove)
#
#func ChargeBar(progress):
#	$ProgressBar.value = progress  * 100
#
#	if progress == 1:
#		var sceneToMove = ResourceLoader.load_threaded_get(path)
#		get_tree().change_scene_to_packed(sceneToMove)
#
#func startChargeBar():
#	var tween = get_tree().create_tween()
#	tween.tween_property($ProgressBar,"value",40,0.2).set_trans(Tween.TRANS_CUBIC)
#	await tween.finished
#	firstBarCharge = true
