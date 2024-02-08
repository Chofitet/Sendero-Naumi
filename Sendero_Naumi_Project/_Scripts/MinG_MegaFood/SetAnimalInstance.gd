extends Control

@export var Instances :=[]
@onready var Spot = $AnchorSpot/Spot
var DragObjects :=[]

func _ready():
	get_parent().Transitioned.connect(SetInstanceAnimal)
	for i in $HBoxContainer.get_children():
		DragObjects.append(i.get_node("DragObject"))

func SetInstanceAnimal():
	for i in Instances:
		if get_node(i).visible == true:
			$PatasController.SetAnimalInstance(Instances.find(i))
			print(Instances.find(i))
			SetCorrectPlate(get_node(i).name)
			

func SetCorrectPlate(instance):
	var resultText = papercontroller.get_node("txt")
	if instance == get_node(Instances[0]).name:
		#smilodonte
		Spot.RigthObject = DragObjects[2]
		resultText.text = "smilodonte"
	elif instance == get_node(Instances[1]).name:
		#gliptodonte
		Spot.RigthObject = DragObjects[0]
		resultText.text = "gliptodonte"
	elif instance == get_node(Instances[2]).name:
		#megaterio
		Spot.RigthObject = DragObjects[3]
		resultText.text = "megaterio"
	elif instance == get_node(Instances[3]).name:
		#macrauquenia
		Spot.RigthObject = DragObjects[0]
		resultText.text = "macrauquenia"

@onready var papercontroller = $PaperController/pivot
@onready var RigthImg = load("res://Sprites/ZonaGeología/face 3.png")
@onready var WrongImg = load("res://Sprites/ZonaGeología/face 2 chica.png")

func SetPaperParameters(resultBool):
	var resultSprite = papercontroller.get_node("result")
	
	if resultBool:
		resultSprite.texture = RigthImg
	else: resultSprite.texture = WrongImg
	

func SetResultEvent():
	$PaperController/AnimationPlayer.play("paper")
	papercontroller.get_node("Button").button_down.connect(EndResultEvent)

func EndResultEvent():
	if get_node(Instances[3]).visible == true:
		$ButtonFin._on_pressed()
	$PaperController/AnimationPlayer.play_backwards("paper")
	
	
