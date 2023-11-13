extends State
class_name AstronomiaZone
@export var Minigames := []
@export var ButtonBack : SubViewportContainer

func Enter():
	PlayerVariables.SaveLastState(self.name)
	inZone.emit()
	ChangeButtonBackVisibility(true, ButtonBack)

func Exit():
	backZone.emit()

func _ready():
	CheckAllTrue(Minigames)
