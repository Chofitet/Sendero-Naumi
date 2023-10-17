extends Node2D
var spots
signal isCorrect
func _ready():
	spots = get_node("Spots")

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
