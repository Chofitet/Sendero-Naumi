extends Control
@onready var anim = $AnimationPlayer
var i = 0
signal Intro4

func _ready():
	$Panel/Button.pressed.connect(NextAnim)
	NextAnim()

func NextAnim():
	anim.play(SetAnim())
	i += 1

func SetAnim() -> String:
	match i:
		0:return "intro_1"
		1:return "Intro_2"
		2:return "Intro_3"
		3:
			Intro4.emit()
			return "Intro_4"
		4: $Button._on_pressed()
	return "RESET"
	
