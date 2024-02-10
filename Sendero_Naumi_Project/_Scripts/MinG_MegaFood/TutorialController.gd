extends Control

@onready var DeslizaPlatosUI = $DeslizaPlatos
@onready var LlevaloBandejaUI = $LlevaloBandeja
@onready var HboxConteiner = get_parent().get_node("HBoxContainer")
@onready var plate = $plate
@export var JuegoState: StateMinigame
signal EndTutorial
var isInTutorial
var OnceSwipe

func _ready():
	JuegoState.Transitioned.connect(CheckInTutorial)

func CheckInTutorial():
	print(get_parent().Instances[0])
	if get_parent().get_node("Instancia1").visible == true:
		isInTutorial = true
		HboxConteiner.LockUnklockGragObjects(false)
	else:
		isInTutorial = false
		DeslizaPlatosUI.visible = false
		LlevaloBandejaUI.visible = false

func FirstSwipe():
	if !isInTutorial or OnceSwipe: return
	get_parent().ConnectSetInstanceAnimalTransitioned()
	DeslizaPlatosUI.visible = false
	OnceSwipe = true
	await get_tree().create_timer(1).timeout
	LlevaloBandejaUI.visible = true
	HboxConteiner.LockUnklockGragObjects(true)

func OnSpot(x):
	if !isInTutorial: return
	LlevaloBandejaUI.get_node("Label").text = "¡MUY BIEN!"
	LlevaloBandejaUI.visible = false
	plate.texture = x.texture
	await  get_tree().create_timer(2).timeout
	DeslizaPlatosUI.visible = true
	DeslizaPlatosUI.get_node("Label").text = "EMPECEMOS"
	var tween = get_tree().create_tween()
	tween.tween_property(plate,"position",Vector2.ZERO,0.8).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(3).timeout
	plate.visible = false
	isInTutorial = false
	EndTutorial.emit()
