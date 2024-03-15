extends Control

@export var Instances :=[]
@onready var Spot = $AnchorSpot/Spot
var DragObjects :=[]
var instanceResourse = InstanceResource.new()
@export var stateMachine : Node
@export var StateToChange : StateMinigame

func _ready():
	ConnectSetInstanceAnimalTransitioned()
	var instanceResourse = ResourceLoader.load("user://InstanceResource.tres")
	if instanceResourse.InstanceMinigames["FoodTruck"] != 0 :
		get_parent().Transitioned.connect(SetInstanceAnimal)
	for i in $HBoxContainer.get_children():
		DragObjects.append(i.get_node("DragObject"))

func ConnectSetInstanceAnimalTransitioned():
	get_parent().Transitioned.connect(SetInstanceAnimal)
	SetInstanceAnimal()

func SetInstanceAnimal():
	for i in Instances:
		if get_node(i).visible == true:
			$PatasController.SetAnimalInstance(Instances.find(i))
			SetCorrectPlate(get_node(i).name)

func SetCorrectPlate(instance):
	var resultText = papercontroller.get_node("txt")
	await get_tree().create_timer(2).timeout
	if instance == get_node(Instances[1]).name:
		#smilodonte
		Spot.RigthObject = DragObjects[2]
		resultText.text = "[b]A LOS MEGATERIOS NOS ENCANTA COMER HIERBAS!

Y LAS SOBRAS QUE DEJAN OTROS ANIMALES!

NUESTRAS GARRAS SON SÓLO PARA DEFENDERNOS,

SOMOS HERVIBOROS Y CARROÑEROS."
	elif instance == get_node(Instances[2]).name:
		#gliptodonte
		Spot.RigthObject = DragObjects[0]
		resultText.text = "gliptodonte"
	elif instance == get_node(Instances[3]).name:
		#megaterio
		Spot.RigthObject = DragObjects[3]
		resultText.text = "[b]A LOS MEGATERIOS NOS ENCANTA COMER HIERBAS!

Y LAS SOBRAS QUE DEJAN OTROS ANIMALES!

NUESTRAS GARRAS SON SÓLO PARA DEFENDERNOS,

SOMOS HERVIBOROS Y CARROÑEROS."
	elif instance == get_node(Instances[4]).name:
		#macrauquenia
		Spot.RigthObject = DragObjects[0]
		resultText.text = "macrauquenia"

@onready var papercontroller = $PaperController/pivot
@onready var RigthImg = load("res://Sprites/ZonaMegafauna/resultado - bien.png")
@onready var WrongImg = load("res://Sprites/ZonaMegafauna/resultado - mal.png")

func SetPaperParameters(resultBool):
	var resultSprite = papercontroller.get_node("result")
	
	if resultBool:
		resultSprite.texture = RigthImg
	else: resultSprite.texture = WrongImg
	

func SetResultEvent():
	$PaperController/AnimationPlayer.play("paper")
	papercontroller.get_node("Button").button_down.connect(EndResultEvent)

func EndResultEvent():
	
	if get_node(Instances[4]).visible == true:
		$ButtonFin._on_pressed()
	else:
		stateMachine.Trigger_On_Child_Transition(StateToChange.name)
	$PaperController/AnimationPlayer.play_backwards("paper")
	
	
