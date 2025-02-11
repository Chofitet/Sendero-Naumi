extends Node
@export var Buttons :=[]
@export var panel : Panel
var LastRock
func _ready():
	for b in Buttons:
		get_node(b).visible = false
		get_node(b).pressed.connect(DisabledButtons)
	

func ActiveButtons():
	if !LastRock: return
	for b in Buttons:
		get_node(b).visible = true
	AcivePanel()

func DisabledButtons():
	if !LastRock: return
	for b in Buttons:
		get_node(b).visible = false
	DisablePanel()

func AcivePanel():
	if LastRock:
		panel.EnterPanel()

func DisablePanel():
	if LastRock:
		panel.ExitPanel()

func lastRock():
	LastRock = true
