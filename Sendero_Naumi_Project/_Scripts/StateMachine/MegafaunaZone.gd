extends State
class_name MegafaunaZone
@export var Minigames := []
@export var ButtonBack : Button 

func Enter():
	PlayerVariables.SaveLastState(self.name)
	inZone.emit()
	ChangeButtonBackVisibility(true, ButtonBack)

func Exit():
	backZone.emit()

func _ready():
	CheckAllTrue(Minigames)
