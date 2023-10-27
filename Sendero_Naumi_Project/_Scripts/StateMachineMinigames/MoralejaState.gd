extends StateMinigame
class_name Moraleja

@export var Moralejas := []

var Content 
var EndOfGame

func _ready():
	Content = get_node("Contenido")
	Content.visible = false

func Enter():
	Content.visible = true
	get_node("Contenido/Timer").start()
	SetMoraleja()

func Exit():
	Content.visible = false
	get_node("Contenido/Timer").stop()
	get_node("Contenido/Button").visible = false

func SetMoraleja():
	var textMoraleja = Moralejas[GetFixedIndex(Moralejas)]
	get_node("Contenido/LblMoraleja").set_deferred("text", textMoraleja) 
 
func TimeOut():
	if !EndOfGame:
		get_node("Contenido/Button").visible = true
	else :
		get_node("Contenido/ButtonChangeScene").visible = true

func isEndOfGame():
	EndOfGame = true
