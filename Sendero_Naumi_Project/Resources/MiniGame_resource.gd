extends Resource
class_name MiniGameResource
#declarar un minijuego cada vez que es creado con el mismo nombre de su scena
@export var StateMinigames = {"minigame1": false, "minigame2" : false,"minigame3" : false}

func Set_State_Minigame(string):
	StateMinigames[string] = true

func RestartMinigames():
	for key in StateMinigames.keys():
		StateMinigames[key] = false
