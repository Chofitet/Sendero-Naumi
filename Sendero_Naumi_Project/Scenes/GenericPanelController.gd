extends Panel
var buttons := []
@export var timeToBtn = 1
@export var SetVisibleFalseWithBtn : bool
@export var timeToAppear : float
@export var offBtnWithBtn : bool
var timer
signal pixels_rendered


func _ready():
	var timerbtnAnim : Timer = Timer.new()
	add_child(timerbtnAnim)
	timerbtnAnim.timeout.connect(AnimButton)
	timerbtnAnim.start(1)
	for btn in get_children():
		if btn is Button:
			buttons.append(btn)
			btn.visible = false
			if SetVisibleFalseWithBtn:
				btn.pressed.connect(SetVisibility.bind(false))
			if offBtnWithBtn:
				btn.pressed.connect(offBtn.bind(btn))
		if btn is Area2D:
			btn.area_entered.connect(SetVisibilityFalseArea2D)
	draw.connect(StartTimer)
	
	SetOffset()
	
	
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

func SetVisibilityFalseArea2D(x):
	visible = false

func StartTimerToAppear():
	await get_tree().create_timer(timeToAppear).timeout
	visible = true

func offBtn(btn):
	btn.visible = false

func Destroy():
	queue_free()

func AnimButton():
	if !buttons : return
	for btn in buttons:
		btn.rotation_degrees = -10
		await get_tree().create_timer(0.5).timeout
		btn.rotation_degrees = 10
		await get_tree().create_timer(0.5).timeout
		
#		var tween = get_tree().create_tween()
#		tween.tween_method(BounceBtn.bind(btn),-15,15,0.5).set_ease(Tween.EASE_IN_OUT)
#		tween.tween_method(BounceBtn.bind(btn),15,-15,0.5).set_ease(Tween.EASE_IN_OUT)

func BounceBtn(value, btn):
	btn.rotation_degrees = value
	

func SetOffset():
	for btn in buttons:
		if (btn != null):
			btn.pivot_offset = Vector2(btn.size.x/2,btn.size.y/2)
