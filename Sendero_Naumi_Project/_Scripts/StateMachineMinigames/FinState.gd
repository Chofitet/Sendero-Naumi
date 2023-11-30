extends StateMinigame
class_name FinState

var Content

func _ready():
	Content = get_node("Contenido")
	Content.visible = false
	
func Enter():
	Content.visible = true
