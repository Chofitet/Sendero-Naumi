extends State
class_name NoZone
@export var ButtonBack : SubViewportContainer
@export var ButtonNaumi :  Button

func _ready():
#	await  get_tree().create_timer(0.1).timeout
#	ButtonNaumi.EnterAnim()
	#$Button.pressed.connect(_on_button_pressed)
	pass

func Enter():
	PlayerVariables.lastState = self.name
	ChangeButtonBackVisibility(false, ButtonBack)
	await  get_tree().create_timer(0.4).timeout
	if PlayerVariables.NumPiso == 4: return
	ButtonNaumi.EnterAnim()

func Exit():
	ButtonNaumi.visible = false

func _on_button_pressed():
	RestartAll()
