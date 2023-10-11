extends Node

var NaumiLevel : int
var MinigameStage = 1

func _ready():
	print(MinigameStage)

func IncreaseNaumiLevel():
	NaumiLevel += 1

func IncreaseMinigameStage():
	MinigameStage += 1
