extends ScrollContainer

@export var limit : float
@export var anchors := []
var pressedPos
var releasePos
var timer
var inGesture
var inhold
var i = 0
var next_anchor

func _ready():
	timer = get_parent().get_node("TimerScroll")
	timer.timeout.connect(calculateGesture)
	next_anchor = get_node(anchors[0]).position.x
	set_deferred("scroll_horizontal",next_anchor)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("TouchScreen"):
		pressedPos = event.position
		timer.start()
		inGesture = true
		inhold = true
		
	if Input.is_action_just_released("TouchScreen"):
		releasePos = event.position
		inhold = false

func calculateGesture() -> void:
	inGesture = false
	if inhold : return
	var d 
	d = releasePos - pressedPos
	if (abs(d.x) < limit) : return
	if abs(d.x) > abs(d.y):
		if d.x < 0:
			var tween = get_tree().create_tween()
			tween.tween_property(self,"scroll_horizontal", set_next_anchor("left"),0.2).set_ease(Tween.EASE_OUT)
			
		else:
			var tween = get_tree().create_tween()
			tween.tween_property(self,"scroll_horizontal", set_next_anchor("rigth"),0.2).set_ease(Tween.EASE_OUT)
			#set_deferred("scroll_vertical", set_next_anchor("up"))


func set_next_anchor(direction) -> float:
	
	if("rigth" == direction):
		if (i != 2):
			i += 1
			var t = (get_viewport_rect().size.x/2) 
			var r = get_node(anchors[i]).position.x
			next_anchor = r - t
	if("left" == direction):
		if (i != 0):
			i -= 1
			next_anchor = get_node(anchors[i]).position.x - (get_viewport_rect().size.x/2)
	return next_anchor
