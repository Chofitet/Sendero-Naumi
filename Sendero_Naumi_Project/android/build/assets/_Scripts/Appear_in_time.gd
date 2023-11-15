extends Timer
@export var isAutomatic = true
@export var isAppear = true
var objects

func _on_tree_entered():
	if isAutomatic :
		StartTime()

func StartTime():
	start()

func _on_timeout():
	if isAppear :
		get_node("child").visible = true
	else: get_node("child").visible = false
