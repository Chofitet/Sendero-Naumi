extends State
class_name MegafaunaZone
@export var Minigames := []
@export var ButtonBack : SubViewportContainer 

func Enter():
	get_parent().get_node("ButtonBack").visible = true
	PlayerVariables.SaveLastState(self.name)
	inZone.emit()
	ChangeButtonBackVisibility(true, ButtonBack)

func Exit():
	backZone.emit()

func _ready():
	pass
	#CheckAllTrue(Minigames)
