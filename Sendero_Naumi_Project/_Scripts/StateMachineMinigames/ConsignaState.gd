extends StateMinigame
class_name Consigna
@export var Consignas := []
@export var FadeInTrasitioned = false

var Content 

func _ready():
	Content = get_node("Contenido")
	Content.visible = false

func Enter():
	$Contenido/btnVolver.visible = true
	Content.visible = true
	Transitioned.emit()
	SetConsigna()

func Exit(incruiseLevel = false):
	$Contenido/btnVolver.visible = false
	if FadeInTrasitioned : 
		get_parent().MakeFade()
		get_parent().fadeInFinish.connect(SetVisibleInEndTransition.bind(false))
	else:
		Content.visible = false
	#Transitioned.emit()

func SetConsigna():
	var textConsigna = Consignas[GetFixedIndex(Consignas)]
	if !get_node("Contenido/LblConsigna"): return
	get_node("Contenido/LblConsigna").set_deferred("text", textConsigna) 

func SetVisibleInEndTransition(x):
	Content.visible = x
