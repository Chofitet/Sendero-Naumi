extends State
class_name NoZone

func Enter():
	get_parent().get_node("ButtonBack").visible = false
	PlayerVariables.lastState = self.name



func _on_button_pressed():
	RestartAll()
