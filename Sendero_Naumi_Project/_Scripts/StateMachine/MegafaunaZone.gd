extends State
class_name MegafaunaZone
@export var Minigames := []
@export var ButtonBack : SubViewportContainer 

func Enter():
	get_parent().get_node("ButtonBack").visible = true
	PlayerVariables.SaveLastState(self.name)
	inZone.emit()
	ChangeButtonBackVisibility(true, ButtonBack)
	ShowMiniGamesButtons()
	ZoomingZone()

func Exit():
	get_node("ZoomingZone").visible = false
	backZone.emit()

func _ready():
	pass
	#CheckAllTrue(Minigames)

#Setea qué botones de minijuegos deben aparecer dependiendo de la zona
func ShowMiniGamesButtons():
	for b in get_node("ZoomingZone/SubViewport/ZoomingZone").get_children():
		if b.has_method("OnZone"):
			b.OnZone()

#Muestra la zona en vista zoom
func ZoomingZone():
	ChangeButtonBackVisibility(true, ButtonBack)
	get_node("ZoomingZone").visible = true
