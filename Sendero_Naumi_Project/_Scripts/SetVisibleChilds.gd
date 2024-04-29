extends Control
var index

func SetVisibleChilds(x):
	for i in get_children():
		i.visible = x

func SetNextChildVisibel(x):
	index += 1
	get_child(index).visible = x
