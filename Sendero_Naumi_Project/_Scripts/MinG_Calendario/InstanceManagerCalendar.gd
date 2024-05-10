extends Control
var Instances :=[]

func _ready():
	for i in range(0,7):
		Instances.append(get_child(i))

func get_instance(i) -> Control:
	return Instances[i]

func get_num_instance() -> int:
	var aux = 0
	for i in Instances:
		if i.visible == true:
			aux = Instances.find(i)
	return aux
