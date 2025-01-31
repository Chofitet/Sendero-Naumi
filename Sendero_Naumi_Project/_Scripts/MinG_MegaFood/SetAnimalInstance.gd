extends Control

@export var Instances :=[]
@onready var Spot = $AnchorSpot/Spot
var DragObjects :=[]
var instanceResourse = InstanceResource.new()
@export var stateMachine : Node 

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
	var resultText = papercontroller.get_node("txt")
	await get_tree().create_timer(2).timeout
	if instance == get_node(Instances[0]).name:
		#smilodonte
		Spot.RigthObject = DragObjects[2]
		resultText.text = "[b]GRRRACIAS![/b]

[b]CAZO TODOS LOS DÍAS 
CON MIS GARRAS Y DIENTES DE SABLE[/b]

PERO HOY DIJE:

'SMILO,
TOMATE EL DÍA.'

Y LA VERDAD QUE NO ME ARREPIENTO

[b]CARNÍVORO 4-LIFE![/b]"
	elif instance == get_node(Instances[1]).name:
		#gliptodonte
		Spot.RigthObject = DragObjects[0]
		resultText.text = "[b]LE ENCANTÓ A MI SEÑORA!![/b]

SUMÉ PUNTOS A LO LOCO, GRACIAS

LOS GLYPTODONTES SOMOS MUY 
ESTRICTOS CON NUESTRA DIETA:
[b]SOLO VEGETALES[/b]

ASI QUE VAMOS A VENIR SEGUIDO!

[b]UN GLYPTOABRAZO[/b]"
	elif instance == get_node(Instances[2]).name:
		#megaterio
		Spot.RigthObject = DragObjects[3]
		resultText.text = "[b]RICASO!![/b]

A LOS MEGATERIOS NOS ENCANTAN
LOS VEGETALES Y LA CARROÑA 
(LAS SOBRAS DE OTROS ANIMALES)
¿CÓMO SABÍAS?

PD: LAS GARRAS SOLO LAS USAMOS
PARA DEFENDERNOS.

PERDON SI TE ASUSTÉ...

[b]RECOMIENDO![/b]"
	elif instance == get_node(Instances[3]).name:
		#macrauquenia
		Spot.RigthObject = DragObjects[0]
		resultText.text = "[b]ME VINO DE DIEZ LA VEGGIE MERIENDA![/b]

CHE, GRACIAS POR NO PREGUNTAR SI SOY 
UN CAMELLO :D

SIEMPRE ME PREGUNTAN ESO :(

PERO NADA QUE VER!
NI PRIMOS SOMOS

TENGO QUE IR A EXTINGUIRME AHORA,
PERO [b]DESPUÉS VUELVO[/b]"

@onready var papercontroller = $PaperController/pivot
@onready var RigthImg = load("res://Sprites/ZonaMegafauna/resultado - bien.png")
@onready var WrongImg = load("res://Sprites/ZonaMegafauna/resultado - mal.png")

func SetPaperParameters(resultBool):
	var resultSprite = papercontroller.get_node("result")
	
	if resultBool:
		resultSprite.texture = RigthImg
	else: resultSprite.texture = WrongImg


func SetResultEvent():
	
	papercontroller.get_node("Button").button_down.connect(EndResultEvent)
	var  PaperAnim = $PaperController/AnimationPlayer
	PaperAnim.play("paper")
	await  PaperAnim.animation_finished
	papercontroller.get_node("Button").EnterAnim()
	

func EndResultEvent():
	$PaperController/AnimationPlayer.play_backwards("paper")
	$BlockScreen.SetVisibility(true)
	if get_node(Instances[3]).visible:
		$FinalPanel.EnterPanel()
	else:
		get_parent().get_parent().Trigger_On_Child_Transition("Juego")
	
	
