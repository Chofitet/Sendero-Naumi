extends State
class_name MegafaunaZone
@export var Minigames := []
@export var ButtonBack : SubViewportContainer 

func Enter():
	get_parent().get_node("ButtonBack").EnterAnim()
	PlayerVariables.SaveLastState(self.name)
	inZone.emit()
	ChangeButtonBackVisibility(true, ButtonBack)
	ShowMiniGamesButtons()
	ZoomingZone()

func Exit():
	get_node("ZoomingZone").visible = false
	backZone.emit()

func _ready():
	CheckAllTrue(Minigames)
	
	for m in Minigames:
		get_node(m).EnterInLevel.connect(DisapearButton)
		get_node(m).CompleteLevelAnim.connect(BlockScreen)

func DisapearButton(btn):
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
