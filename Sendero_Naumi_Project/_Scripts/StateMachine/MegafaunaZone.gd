extends State
class_name MegafaunaZone
@export var Minigames := []


func Enter():
	PlayerVariables.SaveLastState(self.name)
	inZone.emit()
	get_parent().get_node("ButtonBack").visible = true

func Exit():
	backZone.emit()

func _ready():
	CheckAllTrue(Minigames)
