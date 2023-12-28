extends Node

func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		get_node("ColorRect").visible = true
		#get_tree().quit()
