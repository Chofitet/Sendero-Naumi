extends Node
class_name StateMinigame

var path_save_data = "user://"
var file_save_data = "InstanceResource.tres"
var minigameR = InstanceResource.new()
signal Transitioned

func Enter():
	pass

func Exit():
	pass

func Update(_detla : float):
	pass

func Physics_Update(_detla : float):
	pass

func GetInstanceOfMinigame() -> int:
	return minigameR.InstanceMinigames["minigame1"]

func IncruseInstanceOfMinigame():
	minigameR.UpdateInstance("minigame1")

