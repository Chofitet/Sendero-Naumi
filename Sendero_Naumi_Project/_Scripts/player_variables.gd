extends Node

var NaumiLevel : int
var MinigameStage = 1
var lastState = "NoZone"

func IncreaseNaumiLevel():
	NaumiLevel += 1

func IncreaseMinigameStage():
	MinigameStage += 1

func SaveLastState(state):
	lastState = state
