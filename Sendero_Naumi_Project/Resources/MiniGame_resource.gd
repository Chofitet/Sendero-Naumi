extends Resource
class_name MiniGameResource
#declarar un minijuego cada vez que es creado con el mismo nombre de su scena
@export var StateMinigames = {"ToLevelNaumi" : false, 
"FoodTruck" : false,
"Excavando" : false,
"RockFighters" : false,
"Transformando": false,
"Busqueda": false,
"Astronauta": false,
"DondeEstuvo": false,
"ManzanaAcaramelada": false,
"Mamushkas" : false,
"Calendario" : false,
"LastMiniGameComplete" : "",
"noFirstTimePlay" : false,
"lastZone": "NoZone",
"ToUnlockIlands": false,
"FirstTimeInMap": false,
"PassCredits": false,
"MarkAsPlayed": false}

func Set_State_Minigame(string):
	StateMinigames[string] = true

func RestartMinigames():
	for key in StateMinigames.keys():
		StateMinigames[key] = false

func Set_Zone(string):
	StateMinigames["lastZone"] = string

func Get_Zone() -> String:
	return StateMinigames["lastZone"]

func ToLevelNaumiFalse():
	StateMinigames["ToLevelNaumi"] = false

func Set_Last_Minigame(string):
	StateMinigames["LastMiniGameComplete"] = string

func Set_FirstTimeInMap(x):
	StateMinigames["FirstTimeInMap"] = x
