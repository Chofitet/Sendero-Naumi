extends Resource
class_name ZoneResource
#declarar un minijuego cada vez que es creado con el mismo nombre de su scena
@export var StateZones = {"MegafaunaZone": false, "AstronomiaZone" : false}

func Set_State_Zone(string):
	StateZones[string] = true


