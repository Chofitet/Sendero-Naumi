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
	print("enter")
	if x.is_in_group("dragObject"): return
	objectInArea = x

func DeletArea(x):
	print("exit")
	if x.is_in_group("dragObject"): return
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
	elif objectInArea != RigthObject:
		WrongAns.emit()
		once = true

func ObjectArriveToSpot():
	ObjectArriveSpot.emit(objectInArea.get_parent())
	objectInArea.ArriveToSpot.disconnect(ObjectArriveToSpot)
