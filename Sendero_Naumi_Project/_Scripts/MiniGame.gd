extends Node2D

@export var isEndOfZone : bool
@export var NextScene = "Map_Screen"

func _ready():
	if isEndOfZone:
		NextScene = "Naumi_Screen"

func UnlockNextMinigame():
	get_tree().change_scene_to_file("res://Scenes/" + NextScene + ".tscn")
	PlayerVariables.IncreaseMinigameStage()

func _on_tree_exiting():
	if isEndOfZone :
		PlayerVariables.IncreaseNaumiLevel()
	UnlockNextMinigame()



