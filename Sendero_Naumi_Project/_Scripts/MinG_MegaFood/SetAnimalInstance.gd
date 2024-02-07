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
	if instance == get_node(Instances[0]).name:
		#smilodonte
		Spot.RigthObject = DragObjects[2]
	elif instance == get_node(Instances[1]).name:
		#megaterio
		Spot.RigthObject = DragObjects[3]
	elif instance == get_node(Instances[2]).name:
		#gliptodonte
		Spot.RigthObject = DragObjects[0]
	elif instance == get_node(Instances[3]).name:
		#macrauquenia
		Spot.RigthObject = DragObjects[0]
	
