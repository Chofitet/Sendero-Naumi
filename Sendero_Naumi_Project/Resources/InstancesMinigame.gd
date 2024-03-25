extends Resource
class_name InstanceResource
@export var InstanceMinigames = {
	"FoodTruck": 0,
	"Excavando": 0,
	"RockFighters": 0, 
	"Transformando" :0, 
	"Busqueda":0, 
	"Astronauta":0, 
	"DondeEstuvo":0,
	"ManzanaAcaramelada":0,
	"Mamushkas":0}

func UpdateInstance(string):
	InstanceMinigames[string] = InstanceMinigames[string] + 1

func RestartIntances():
	for key in InstanceMinigames.keys():
		InstanceMinigames[key] = 0

func RestartOneInstance(text):
	InstanceMinigames[text] = 0
