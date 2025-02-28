extends State
class_name NoZone
@export var ButtonBack : SubViewportContainer
@export var ButtonNaumi :  Button

func _ready():
	#$Button.pressed.connect(_on_button_pressed)
	pass

func Enter():
	PlayerVariables.lastState = self.name
	ChangeButtonBackVisibility(false, ButtonBack)
	ButtonNaumi.EnterAnim()

func Exit():
	ButtonNaumi.visible = false

func _on_button_pressed():
	RestartAll()
