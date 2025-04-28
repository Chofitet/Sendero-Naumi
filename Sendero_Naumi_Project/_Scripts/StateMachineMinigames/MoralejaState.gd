extends StateMinigame
class_name Moraleja

@export var Moralejas := []
@export var Instancias := []
@export var buttons := [Button]

@export var FadeInBeteewnInstance = false

var i = 0
var Content 
var EndOfGame

func _ready():
	Content = get_node("Contenido")
	Content.visible = false

func Enter():
	if FadeInBeteewnInstance:
		get_parent().fadeOutStart.connect(SetVisibleInEndTransition.bind(true))
	else:
		Content.visible = true
		SetMoraleja()
		SetInstancia(true)
		Transitioned.emit()

func Exit(incruiseLevel = false):
	if FadeInBeteewnInstance:
		get_parent().MakeFade()
		get_parent().fadeInFinish.connect(SetVisibleInEndTransition.bind(false))
	else :
		Content.visible = false
		SetInstancia(false)
		if buttons.is_empty(): return
		for b in buttons:
			get_node(b).visible = true
	

func SetMoraleja():
	if Moralejas.is_empty() : return
	var textMoraleja = Moralejas[GetFixedIndex(Moralejas)]
	get_node("Contenido/Conteiner/LblMoraleja").set_deferred("text", textMoraleja) 
 
func isEndOfGame():
	EndOfGame = true

func SetInstancia(x):
	if Instancias.is_empty(): return
	get_node(Instancias[GetFixedIndex(Instancias)]).visible = x
	if x: i += 1

func SetVisibleInEndTransition(x):
	Content.visible = x
	if x: SetMoraleja()
	SetInstancia(x)
	
	if !x:
		if buttons.is_empty(): return
		for b in buttons:
			get_node(b).visible = true
	
	if !x: get_parent().fadeInFinish.disconnect(SetVisibleInEndTransition)
	else:  
		get_parent().fadeOutStart.disconnect(SetVisibleInEndTransition)
		Transitioned.emit()
