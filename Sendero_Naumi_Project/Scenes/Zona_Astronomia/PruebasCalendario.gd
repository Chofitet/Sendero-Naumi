extends Control
var sprites :=[]
var index = 0

func _ready():
	for i in get_children():
		if i is Sprite2D:
			sprites.append(i)

func Next():
	index += 1
	for i in sprites:
		i.visible = false
		sprites[index].visible = true
	
	if index >= sprites.size():
		index = 0
