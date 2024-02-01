extends Node2D

signal AllTrue
var childs :=[]

# Condiciones: Todos los hijos directos deben de tener un script
# con la variable isComplete

func _ready():
	for c in get_children():
		childs.append(c)
		

func CheckTrue():
	var i = 0
	var b
	for c in childs:
		if !c.isComplete:
			b = false
		else:
			i += 1
			b = CheckOthers(i)
	if b: AllTrue.emit()

func CheckOthers(i)-> bool:
	if i == childs.size():
		return true
	else: return false
