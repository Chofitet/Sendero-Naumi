extends StateMinigame
class_name Moraleja

@export var Moralejas := []

var Content 

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

func SetMoraleja():
	var numMoraleja = GetInstanceOfMinigame()
	var textMoraleja = Moralejas[int(numMoraleja)]
	get_node("Contenido/LblMoraleja").set_deferred("text", textMoraleja) 
 
func TimeOut():
	get_node("Contenido/Button").visible = true
