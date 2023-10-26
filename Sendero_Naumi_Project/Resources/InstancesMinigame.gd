extends Resource
class_name InstanceResource
@export var InstanceMinigames = {"minigame1": 0, "minigame2" : 0,"minigame3" : 0}

func UpdateInstance(string):
	InstanceMinigames[string] =+ 1

func RestartIntances():
	for key in InstanceMinigames.keys():
		InstanceMinigames[key] = false
