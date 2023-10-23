extends State
class_name NoZone
var ZoneComplete
@export var Minigames := []
var minigamesResource = MiniGameResource.new()

func Enter():
	print("Enter in: " + self.name)
	CheckAllTrue()

func CheckAllTrue():
	var i = 0
	for m in Minigames:
		if !minigamesResource.StateMinigames[get_node(m).name]: return
		else: i += 1
		
		if(i == len(minigamesResource.StateMinigames)):
			ZoneComplete = true
			print(ZoneComplete)
