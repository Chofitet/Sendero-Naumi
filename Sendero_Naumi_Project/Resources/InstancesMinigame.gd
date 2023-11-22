extends Resource
class_name InstanceResource
@export var InstanceMinigames = {"RockFighters": 0, "Transformando" :0, "Busqueda":0}

func UpdateInstance(string):
	InstanceMinigames[string] = InstanceMinigames[string] + 1

func RestartIntances():
	for key in InstanceMinigames.keys():
		InstanceMinigames[key] = 0
