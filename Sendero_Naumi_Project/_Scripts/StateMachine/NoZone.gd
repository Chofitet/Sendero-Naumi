extends State
class_name NoZone
@export var ButtonBack : SubViewportContainer

func Enter():
	PlayerVariables.lastState = self.name
	ChangeButtonBackVisibility(false, ButtonBack)


func _on_button_pressed():
	RestartAll()
