extends StateMinigame
class_name Consigna
@export var Consignas := []

var Content 

func _ready():
	Content = get_node("Contenido")
	Content.visible = false

func Enter():
	Content.visible = true
	Transitioned.emit()
	SetConsigna()

func Exit(incruiseLevel = false):
	Content.visible = false
	Transitioned.emit()

func SetConsigna():
	var textConsigna = Consignas[GetFixedIndex(Consignas)]
	if !get_node("Contenido/LblConsigna"): return
	get_node("Contenido/LblConsigna").set_deferred("text", textConsigna) 

