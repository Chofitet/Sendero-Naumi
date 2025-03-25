extends TextureRect
var geologia = preload("res://Sprites/Mapa/geologia_mapa.png")
var universo = preload("res://Sprites/Mapa/universo_mapa.png")
var megafauna = preload("res://Sprites/Mapa/megafauna_mapa.png")

var texturas = {"GeologiaZone" : geologia,
"AstronomiaZone":universo,
"MegafaunaZone": megafauna}

func _ready():
	checkZone()
	ShowPines()

func checkZone():
	if PlayerVariables.lastState == "NoZone":
		#get_tree().change_scene_to_file("res://Scenes/Map_Screen.tscn")
		return
	texture = texturas[PlayerVariables.lastState]

func ShowPines():
	for p in $Pines.get_children():
		if p.name == PlayerVariables.lastState:
			for subp in p.get_children():
				await get_tree().create_timer(0.9).timeout
				subp.get_node("AnimationPlayer").play("aparicion")
	
	$PanelCompletada.EnterPanel()
