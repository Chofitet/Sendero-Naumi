extends Node2D
var spots
signal isCorrect
@export var conteiner : String 
func _ready():
	spots = self
	if conteiner != "" :
		spots = get_node(conteiner)
	

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
