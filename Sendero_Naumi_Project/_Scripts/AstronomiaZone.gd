extends State
class_name AstronomiaZone
@export var Minigames := []
@export var ButtonBack : SubViewportContainer

func _ready():
	CheckAllTrue(Minigames)
	
	for m in Minigames:
		get_node(m).EnterInLevel.connect(DisapearButton)
		get_node(m).CompleteLevelAnim.connect(BlockScreen)

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


func DisapearButton(btn):
	get_parent().get_node("ButtonNaumi").ExitAnim(true)
	get_parent().get_node("ButtonBack").ExitAnim(true)
	for m in Minigames:
		var M = get_node(m)
		if btn != M:
			var tween = get_tree().create_tween()
			tween.tween_property(M,"modulate",Color.TRANSPARENT,0.01)

#Setea qué botones de minijuegos deben aparecer dependiendo de la zona
func ShowMiniGamesButtons():
	for b in get_node("ZoomingZone/SubViewport/ZoomingZone").get_children():
		if b.has_method("OnZone"):
			b.OnZone()

#Muestra la zona en vista zoom
func ZoomingZone():
	ChangeButtonBackVisibility(true, ButtonBack)
	get_node("ZoomingZone").visible = true

func BlockScreen():
	$BlockScreen.visible = true
	for m in Minigames:
		var M = get_node(m)
		M.stopAnim()
	await get_tree().create_timer(2).timeout
	$BlockScreen.visible = false
	for m in Minigames:
		var M = get_node(m)
		M.resumeAnim()
