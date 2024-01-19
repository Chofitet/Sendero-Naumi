extends Node2D
signal isCorrect
@export var spots : Node2D


func check_if_all_true():
	var i = 0
	for s in spots.get_children():
		if (!s.isInPosition):
			return
			print("no true")
		else: 
			print("true")
			i += 1
	
	if (i == spots.get_child_count()):
		
		isCorrect.emit()

func  CheckCorrectorIncorrect():
	for s in spots.get_children():
			if (!s.isInPosition):
				return
				print("no true")
			else: 
				print("true")
				i += 1
