@tool
class_name  _IntermediateSignal
extends Node
signal ButtonPress
@export var Data : IntermediateData
@export var Delay : float

func EmitSignal(numOfPanel):
	if Data.NumberOfPanel - 1 == numOfPanel: 
		print("Signal of panel " + str(Data.NumberOfPanel))
		await get_tree().create_timer(Delay).timeout
		ButtonPress.emit()

func ConnectSignal():
	print("Signal connected")
	get_parent().connect(Data.Get_Signal(),EmitSignal)


func AssingIntermediateData(data):
	Data = data
