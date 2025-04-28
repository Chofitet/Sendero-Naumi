extends StateMinigame
class_name Juego

@export var NextState: StateMinigame
@export var StateMachine : Node
@export var InstanciasMinijuego := []
@export var FadeInConsigna = false
@export var FadeInBeteewnInstance = false
@export var FadeInToFin = false

var Content
var once = false

func _ready():
	Content = get_node("Contenido")
	Content.visible = false
	
func Enter():
	var lastState = get_parent().lastState
	if FadeInConsigna and lastState == "consigna":
		get_parent().fadeOutStart.connect(SetVisibleInEndTransition.bind(true))
	elif FadeInBeteewnInstance and (lastState == "juego" or lastState == "moraleja"):
		get_parent().fadeOutStart.connect(SetVisibleInEndTransition.bind(true))
	else:
		Content.visible = true
		SetVisibilityHUD(true)
		SetGameInstance(true)
		Transitioned.emit()
	

func Exit(incruiseLevel = false):
	var lastState = get_parent().lastState
	var nextState = get_parent().nextState
	if FadeInBeteewnInstance and lastState == "juego":
		get_parent().MakeFade()
		get_parent().fadeInFinish.connect(SetVisibleInEndTransition.bind(false,incruiseLevel))
	elif FadeInToFin and nextState == "fin":
		get_parent().MakeFade()
		get_parent().fadeInFinish.connect(SetVisibleInEndTransition.bind(false,false))
	else:
		Content.visible = false
		SetVisibilityHUD(false)
		SetGameInstance(false)
		if !incruiseLevel: 
			IncruseInstanceOfMinigame()
	

#Muestra la instancia de minijuegos correspondiente segun lo guardado en los saves del jugador
func SetGameInstance(setBool):
	var numGame = GetInstanceOfMinigame()
	print(numGame)
	get_node(InstanciasMinijuego[numGame]).visible = setBool
	

func Set_next_Instance():
	StateMachine.Trigger_On_Child_Transition(NextState.name)


func SetVisibleInEndTransition(x, incruiseLevel = true):
	if x: print("enter, " + str(incruiseLevel))
	if !x: print("exit, " + str(incruiseLevel))
	
	Content.visible = x
	SetVisibilityHUD(x)
	SetGameInstance(x)
	
	if !incruiseLevel and !x: 
		IncruseInstanceOfMinigame()
		
	if x: Transitioned.emit()
	
	if !x: get_parent().fadeInFinish.disconnect(SetVisibleInEndTransition)
	else:  get_parent().fadeOutStart.disconnect(SetVisibleInEndTransition)
	
