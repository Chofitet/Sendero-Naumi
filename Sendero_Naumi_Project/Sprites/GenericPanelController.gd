extends Panel
var buttons := []
@export var timeToBtn = 3.5
var timer
signal pixels_rendered

func _ready():
	for btn in get_children():
		if btn is Button:
			buttons.append(btn)
			btn.visible = false
	draw.connect(StartTimer)
	
func StartTimer():
	timer = get_tree().create_timer(timeToBtn)
	timer.timeout.connect(ShowButtons.bind(true))

func ShowButtons(x):
	for btn in buttons:
		if (btn != null):
			btn.visible = x

func check_pixels_rendered():
	var total_pixels = 0
	var rect = get_rect().position + get_rect().size
	total_pixels += rect.x * rect.y
	
	if total_pixels >= 100:  
		pixels_rendered.emit()

func SetVisibility(x):
	visible = x
