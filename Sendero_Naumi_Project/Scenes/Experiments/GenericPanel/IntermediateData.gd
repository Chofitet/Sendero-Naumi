@tool
extends Resource
class_name IntermediateData

@export var NumberOfPanel : int = 1
@export var Place : place

enum place {
	rigth,
	center,
	left
}

func Get_Signal() -> String:
	var _signal
	
	match Place:
		place.rigth: _signal = "RigthBTNPress"
		place.left: _signal = "LeftBTNPress"
		place.center: _signal = "CenterBTNPress"
	
	return _signal

func Get_Place() -> String:
	var _signal
	
	match Place:
		place.rigth: _signal = "rigth"
		place.left: _signal = "left"
		place.center: _signal = "center"
	
	return _signal
