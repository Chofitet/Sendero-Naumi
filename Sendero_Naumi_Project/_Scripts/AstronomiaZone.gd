extends State
class_name AstronomiaZone
@export var Minigames := []
@export var ButtonBack : SubViewportContainer

func Enter():
	get_parent().get_node("ButtonBack").EnterAnim()
	#guarda cuál fue la última zona clikeada para que sea esta la que aparezca cuando se vuelva de algún minijuego
	PlayerVariables.SaveLastState(self.name)
	inZone.emit()
	ZoomingZone()
	ShowMiniGamesButtons()

func Exit():
	get_node("ZoomingZone").visible = false
	backZone.emit()

func _ready():
	CheckAllTrue(Minigames)

#Setea qué botones de minijuegos deben aparecer dependiendo de la zona
func ShowMiniGamesButtons():
	for b in get_node("ZoomingZone/SubViewport/ZoomingZone").get_children():
		if b.has_method("OnZone"):
			b.OnZone()

#Muestra la zona en vista zoom
func ZoomingZone():
	ChangeButtonBackVisibility(true, ButtonBack)
	get_node("ZoomingZone").visible = true
