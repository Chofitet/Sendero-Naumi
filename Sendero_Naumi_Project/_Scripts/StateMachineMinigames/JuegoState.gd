extends StateMinigame
class_name Juego

@export var NextState: StateMinigame
@export var StateMachine : Node
@export var InstanciasMinijuego := []

var Content
var once = false

func _ready():
	Content = get_node("Contenido")
	Content.visible = false
	
func Enter():
	Content.visible = true
	SetVisibilityHUD(true)
	SetGameInstance(true)
	Transitioned.emit()

func Exit():
	Content.visible = false
	SetGameInstance(false)
	SetVisibilityHUD(false)
	IncruseInstanceOfMinigame()

#Muestra la instancia de minijuegos correspondiente segun lo guardado en los saves del jugador
func SetGameInstance(setBool):
	var numGame = GetInstanceOfMinigame()
	print(numGame)
	get_node(InstanciasMinijuego[numGame]).visible = setBool
	

func Set_next_Instance():
	StateMachine.Trigger_On_Child_Transition(NextState.name)


