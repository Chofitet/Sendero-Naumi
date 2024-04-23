extends Control


func SetVisibleChilds(x):
	for i in get_children():
		i.visible = x
