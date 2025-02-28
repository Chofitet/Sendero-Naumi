@tool
class_name  _IntermediateSignal
extends Node
signal ButtonPress
@export var Data : IntermediateData
@export var Delay : float

func EmitSignal(numOfPanel):
	if Data.NumberOfPanel  == numOfPanel - 1: 
		await get_tree().create_timer(Delay).timeout
		ButtonPress.emit()

func ConnectSignal():
	get_parent().connect(Data.Get_Signal(),EmitSignal)


func AssingIntermediateData(data):
	Data = data
