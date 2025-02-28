extends Area2D

@export var  RigthObject : Area2D
var objectInArea
signal RightAns
signal WrongAns
var once
signal OnSpot
signal ObjectArriveSpot

func _ready():
	area_entered.connect(CheckRigthArea)
	area_exited.connect(DeletArea)

func _input(event: InputEvent) -> void:
	if once: return
	if Input.is_action_just_released("TouchScreen"):
		CheckAnswer()
	
func CheckRigthArea(x):
	objectInArea = x

func DeletArea(x):
	objectInArea = null

func Reset():
	once = false
	objectInArea = null

func CheckAnswer():
	if objectInArea == null : return
	OnSpot.emit(objectInArea.get_parent())
	objectInArea.ArriveToSpot.connect(ObjectArriveToSpot)
	if objectInArea == RigthObject:
		RightAns.emit()
		once = true
		print("r")
	elif objectInArea != RigthObject:
		WrongAns.emit()
		once = true
		print("w")

func ObjectArriveToSpot():
	ObjectArriveSpot.emit(objectInArea.get_parent())
	objectInArea.ArriveToSpot.disconnect(ObjectArriveToSpot)
