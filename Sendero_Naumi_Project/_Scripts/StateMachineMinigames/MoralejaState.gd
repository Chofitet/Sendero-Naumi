extends StateMinigame
class_name Moraleja

@export var Moralejas := []
@export var Instancias := []
@export var buttons := [Button]

var i = 0
var Content 
var timer
var EndOfGame

func _ready():
	Content = get_node("Contenido")
	Content.visible = false
	timer = get_node("Contenido/Timer")
	timer.timeout.connect(TimeOut)

func Enter():
	Content.visible = true
	timer.start()
	SetMoraleja()
	SetInstancia(true)

func Exit():
	Content.visible = false
	timer.stop()
	for b in buttons:
		get_node(b).visible = true
	SetInstancia(false)

func SetMoraleja():
	var textMoraleja = Moralejas[GetFixedIndex(Moralejas)]
	get_node("Contenido/Conteiner/LblMoraleja").set_deferred("text", textMoraleja) 
 
func TimeOut():
	pass
	#for b in buttons:
		#get_node(b).visible = true

func isEndOfGame():
	EndOfGame = true

func SetInstancia(x):
	get_node(Instancias[GetFixedIndex(Instancias)]).visible = x
	if x: i += 1
