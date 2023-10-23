extends State
class_name AstronomiaZone

@export var label : Label

func Enter():
	label.text = self.name
