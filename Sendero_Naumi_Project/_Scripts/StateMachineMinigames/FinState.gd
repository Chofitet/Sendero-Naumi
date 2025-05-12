extends StateMinigame
class_name FinState

var Content
@export var FadeInFin = false

func _ready():
	Content = get_node("Contenido")
	Content.visible = false
	
func Enter():
	if FadeInFin:
		get_parent().fadeOutStart.connect(SetVisibleInEndTransition.bind(true))
	else:
		Content.visible = true
		Transitioned.emit()

func SetVisibleInEndTransition(x):
	Content.visible = x
	if x:Transitioned.emit()
