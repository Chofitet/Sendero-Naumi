extends Node2D

@export var isEndOfZone : bool
@export var NextScene = "Map_Screen"

func _ready():
	if isEndOfZone:
		NextScene = "Naumi_Screen"

func UnlockNextMinigame():
	PlayerVariables.IncreaseMinigameStage()


func GameComplete():
	if isEndOfZone :
		PlayerVariables.IncreaseNaumiLevel()
	UnlockNextMinigame()


func _on_draggeable_system_is_correct():
	GameComplete()
