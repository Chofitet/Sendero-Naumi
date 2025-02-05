extends Control

@onready var DeslizaPlatosUI = $DeslizaPlatos
@onready var LlevaloBandejaUI = $LlevaloBandeja
@onready var HboxConteiner = get_parent().get_node("HBoxContainer")
@onready var plate = $plate
@export var JuegoState: StateMinigame
@export var StateMachine : Node
signal EndTutorial
var isInTutorial
var OnceSwipe
signal InTutorial

func CheckInTutorial():
	if get_parent().get_node("Instancia1").visible == true:
		isInTutorial = true
		HboxConteiner.LockUnklockGragObjects(false)
		DeslizaPlatosUI.EnterPanel()
		InTutorial.emit()
	else:
		isInTutorial = false
		DeslizaPlatosUI.visible = false
		LlevaloBandejaUI.visible = false

func FirstSwipe():
	if !isInTutorial or OnceSwipe: return
	DeslizaPlatosUI.ExitPanel()
	OnceSwipe = true
	await get_tree().create_timer(1).timeout
	LlevaloBandejaUI.EnterPanel()
	HboxConteiner.LockUnklockGragObjects(true)

func OnSpot(x):
	if !isInTutorial: return
	LlevaloBandejaUI.ExitPanel()
#	plate.visible = true
#	plate.texture = x.texture
	await  get_tree().create_timer(3).timeout
	DeslizaPlatosUI.visible = false
	LlevaloBandejaUI.visible = false
#	DeslizaPlatosUI.visible = true
#	DeslizaPlatosUI.get_node("Label").text = "EMPECEMOS"
#	await  get_tree().create_timer(2).timeout
	isInTutorial = false
	EndTutorial.emit()
