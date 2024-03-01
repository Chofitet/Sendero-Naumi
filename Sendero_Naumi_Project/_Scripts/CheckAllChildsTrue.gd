extends Node2D

signal AllTrue
var childs :=[]
@export var PercentComplete : float
@export var debug : bool

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
	if b:
		AllTrue.emit()

func CheckPartialChildTrue():
	var i = 0
	var b
	for c in childs:
		if !c.isComplete:
			b = false
		else:
			i += 1
			b = CheckOthers(i,CalculatePercent())
	if b:
		AllTrue.emit()
	

func CheckOthers(i, x = childs.size())-> bool:
	if i == x:
		return true
	else: return false

func CalculatePercent() -> float:
	var num 
	num = PercentComplete * childs.size()
	
	return round(num)

func _process(delta):
	if debug:
		AllTrue.emit()
		debug = false
