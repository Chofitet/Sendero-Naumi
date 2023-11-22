extends State
class_name NoZone
@export var ButtonBack : SubViewportContainer

func Enter():
	get_parent().get_node("ButtonBack").visible = false
	PlayerVariables.lastState = self.name
	ChangeButtonBackVisibility(false, ButtonBack)


func _on_button_pressed():
	RestartAll()
