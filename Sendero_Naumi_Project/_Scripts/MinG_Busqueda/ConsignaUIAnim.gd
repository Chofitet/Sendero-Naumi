extends Control
var timer
var initposition 

func _ready():
	visible = true
	timer = get_node("Timer")
	timer.timeout.connect(Anim)
	position = Vector2((get_viewport_rect().size.x - size.x)/2, position.y)
	initposition = position

func StartTimer():
	$consignaPanel.EnterPanel()
	position = initposition
	visible = true
	timer.start()

func Anim():
	var tween1 = get_tree().create_tween()
	tween1.tween_property(self,"position", Vector2(0,110) , 0.5 ).set_ease(Tween.EASE_OUT)
	timer.stop()
