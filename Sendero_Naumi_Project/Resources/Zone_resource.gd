extends Resource
class_name ZoneResource
#declarar un minijuego cada vez que es creado con el mismo nombre de su scena
@export var StateZones = {
"MegafaunaZone": false, 
"AstronomiaZone" : false, 
"GeologiaZone":false,
"MuseoHistoryZone": false,
"CuaternarioZone":false,
"AmbientesZone" : false,
"ErasGeologicasZone" : false,
"UnlockedMegafaunaZone" : false,
"UnlockedAstronomiaZone" : false,
"UnlockedGeologiaZone" : false,
"UnlockedMuseoHistoryZone" : false,
"UnlockedCuaternarioZone":false,
"UnlockedAmbientesZone" : false,
"UnlockedErasGeologicasZone" : false}


func Set_State_Zone(string):
	StateZones[string] = true

func RestartZones():
	for key in StateZones.keys():
		StateZones[key] = false

