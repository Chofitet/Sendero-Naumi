extends StateMinigame
class_name Consigna
@export var Consignas := []

var Content 

func _ready():
	Content = get_node("Contenido")
	Content.visible = false

func Enter():
	Content.visible = true
	get_node("Contenido/Timer").start()
	SetConsigna()

func Exit():
	get_node("Contenido/Timer").stop()
	Content.visible = false

func SetConsigna():
	var numConsigna = GetInstanceOfMinigame()
	var textConsigna = Consignas[int(numConsigna)]
	get_node("Contenido/LblConsigna").set_deferred("text", textConsigna) 

func TimeOut():
	get_node("Contenido/Button").visible = true
