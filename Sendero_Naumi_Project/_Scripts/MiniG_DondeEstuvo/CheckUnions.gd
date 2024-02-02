extends VBoxContainer
var i : int = 0
@onready var Childs = get_children()
signal AllConnect
@export var btn : Button

func checkUnions():
	i = 0
	for u in Childs:
		if u.lastEnter == null : 
			btn.visible = false
			return
		i = i + 1
	if i == Childs.size():
		btn.visible = true
		
