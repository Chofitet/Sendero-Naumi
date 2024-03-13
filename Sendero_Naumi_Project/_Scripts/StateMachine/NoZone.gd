extends State
class_name NoZone
@export var ButtonBack : SubViewportContainer
@export var ButtonNaumi :  TextureRect

func _ready():
	$Button.pressed.connect(_on_button_pressed)

func Enter():
	get_parent().get_node("ButtonBack").visible = false
	PlayerVariables.lastState = self.name
	ChangeButtonBackVisibility(false, ButtonBack)
	ButtonNaumi.visible = true

func Exit():
	ButtonNaumi.visible = false

func _on_button_pressed():
	RestartAll()
