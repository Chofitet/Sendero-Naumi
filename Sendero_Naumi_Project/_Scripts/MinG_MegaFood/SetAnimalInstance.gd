extends Control

@export var Instances :=[]
@onready var Spot = $AnchorSpot/Spot
var DragObjects :=[]
var instanceResourse = InstanceResource.new()
@export var stateMachine : Node 
signal EnterResult
signal EnterResultDelay
@export var Doodles : Array[Texture] 
@export var Labels : Array[LabelSettings]
func _ready():
	get_parent().Transitioned.connect(SetInstanceAnimal)
	var instanceResourse = ResourceLoader.load("user://InstanceResource.tres")
	if instanceResourse.InstanceMinigames["FoodTruck"] != 0 :
		get_parent().Transitioned.connect(SetInstanceAnimal)
	for i in $HBoxContainer.get_children():
		DragObjects.append(i.get_node("DragObject"))

func SetInstanceAnimal():
	for i in Instances:
		if get_node(i).visible == true:
			$PatasController.SetAnimalInstance(Instances.find(i))
			SetCorrectPlate(get_node(i).name)

func SetCorrectPlate(instance):
	var resultText : Label = papercontroller.get_node("txt")
	var resultFace = papercontroller.get_node("result")
	
	await get_tree().create_timer(2).timeout
	if instance == get_node(Instances[0]).name:
		#smilodonte
		Spot.RigthObject = DragObjects[2]
		resultFace.texture = Doodles[0]
		resultText.label_settings = Labels[0]
		resultText.text = "GRRRACIAS!

CAZO TODOS LOS DÌAS 
CON MIS GARRAS Y DIENTES DE SABLE

PERO HOY DIJE:

''SMILO,
TOMATE EL DÌA.''

Y LA VERDAD QUE NO ME ARREPIENTO

CARNÍVORO 4-LIFE!"
	elif instance == get_node(Instances[1]).name:
		#gliptodonte
		Spot.RigthObject = DragObjects[0]
		resultFace.texture = Doodles[1]
		resultText.label_settings = Labels[1]
		resultText.text = "LE ENCANTÓ A MI SEÑORA!!

SUMÉ PUNTOS A LO LOCO, GRACIAS!

LOS GLYPTODONTES SOMOS MUY 
ESTRICTOS CON NUESTRA DIETA:
SOLO VEGETALES.

ASI QUE VAMOS A VENIR SEGUIDO!

UN GLYPTOABRAZO"
	elif instance == get_node(Instances[2]).name:
		#megaterio
		Spot.RigthObject = DragObjects[3]
		resultFace.texture = Doodles[2]
		resultText.label_settings = Labels[2]
		resultText.text = "RICASO!!!!

A LOS MEGATERIOS 
NOS ENCANTAN LOS VEGETALES 
Y LA CARROÑA 
(LAS SOBRAS DE OTROS ANIMALES)
CÓMO SABÍAS????

PD: 
	LAS GARRAS SOLO LAS USAMOS
	PARA DEFENDERNOS.

   PERDON SI TE ASUSTÉ...

RECOMIENDO!!!!!! ~"
	elif instance == get_node(Instances[3]).name:
		#macrauquenia
		Spot.RigthObject = DragObjects[0]
		resultFace.texture = Doodles[3]
		resultText.label_settings = Labels[3]
		resultText.text = "ME VINO DE DIEZ LA 
VEGGIE MERIENDA!

CHE, GRACIAS POR NO PREGUNTAR 
SI SOY UN CAMELLO :D

SIEMPRE ME PREGUNTAN ESO :(

PERO NADA QUE VER!
NI PRIMOS SOMOS!!

AHORA TENGO QUE IR A EXTINGUIRME,
PERO DESPUÉS VUELVO"

@onready var papercontroller = $PaperController/pivot
@onready var RigthImg = load("res://Sprites/ZonaMegafauna/resultado - bien.png")
@onready var WrongImg = load("res://Sprites/ZonaMegafauna/resultado - mal.png")



func SetResultEvent():
	EnterResult.emit()
	papercontroller.get_node("Button").button_down.connect(EndResultEvent)
	var  PaperAnim = $PaperController/AnimationPlayer
	PaperAnim.play("paper")
	SoundManager.play("level","takePaper")
	await  get_tree().create_timer(5).timeout
	papercontroller.get_node("Button").EnterAnim()
	EnterResultDelay.emit()
	

func EndResultEvent():
	SoundManager.play("level","leavePaper")
	$PaperController/AnimationPlayer.play_backwards("paper")
	$BlockScreen.SetVisibility(true)
	if get_node(Instances[3]).visible:
		$FinalPanel.EnterPanel()
	else:
		get_parent().get_parent().Trigger_On_Child_Transition("Juego")
	
	
