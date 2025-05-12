extends TextureRect
var geologia = preload("res://Sprites/Mapa/geologia_mapa.png")
var universo = preload("res://Sprites/Mapa/universo_mapa.png")
var megafauna = preload("res://Sprites/Mapa/megafauna_mapa.png")
@export var debugTest = false
var texturas = {"GeologiaZone" : geologia,
"AstronomiaZone":universo,
"MegafaunaZone": megafauna}

func _ready():
	checkZone()
	if PlayerVariables.DebugMode or debugTest: DebugTest()
	else: ShowPines()

func checkZone():
	if PlayerVariables.lastState == "NoZone":
		#get_tree().change_scene_to_file("res://Scenes/Map_Screen.tscn")
		return
	texture = texturas[PlayerVariables.lastState]

func ShowPines():
	for p in $Pines.get_children():
		if p.name == PlayerVariables.lastState:
			for subp in p.get_children():
				await get_tree().create_timer(0.6).timeout
				subp.get_node("AnimationPlayer").play("aparicion")
				$soundsSecuencias.PlayEvent(PlayerVariables.lastState, 0.3)
	
	await get_tree().create_timer(0.9).timeout
	$PanelCompletada.EnterPanel()

func DebugTest():
	for subp in $Pines/GeologiaZone.get_children():
		await get_tree().create_timer(0.6).timeout
		subp.get_node("AnimationPlayer").play("aparicion")
		$soundsSecuencias.PlayEvent("GeologiaZone",0.3)
	
	await get_tree().create_timer(0.9).timeout
	$PanelCompletada.EnterPanel()
