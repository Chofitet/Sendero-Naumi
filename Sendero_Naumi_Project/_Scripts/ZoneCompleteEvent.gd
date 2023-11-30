extends TextureRect
var geologia = load("res://Sprites/Mapa/geologia_mapa.png")
var texturas = {"GeologiaZone" : geologia}

func _ready():
	checkZone()

func checkZone():
	pass
	#texture = texturas[PlayerVariables.lastState] 
