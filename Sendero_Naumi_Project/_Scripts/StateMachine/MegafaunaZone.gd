extends State
class_name MegafaunaZone
var ZoneComplete
@export var label : Label
@export var Minigames := []
var minigamesResource = MiniGameResource.new()
var i = 0

func Enter():
	label.text = self.name
	CheckAllTrue()

func CheckAllTrue():
	for m in Minigames:
		if (minigamesResource.StateMinigames[get_node(m).name]) == true: 
			return
		else: i += 1
		
		if(i == len(Minigames)):
			ZoneComplete = true
			print(ZoneComplete)

