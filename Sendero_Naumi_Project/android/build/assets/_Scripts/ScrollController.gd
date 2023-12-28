extends ScrollContainer

@export var anchors := []
var i = 0
var pressedPos : Vector2
var releasePos : Vector2
var timer 
var holdClick
var next_anchor 

func _ready():
	timer = get_parent().get_node("TimerScroll")
	timer.timeout.connect(calculateGesture)
	set_deferred("scroll_vertical",next_anchor)
	var y = get_node(anchors[i]).global_position.y 
	next_anchor = get_viewport_rect().size.y*3 - (get_viewport_rect().size.y/2)
	set_deferred("scroll_vertical",next_anchor)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("TouchScreen"):
		pressedPos = event.position
		timer.start()
		holdClick = true
		
		
	if Input.is_action_just_released("TouchScreen"):
		releasePos = event.position
		holdClick = false



func calculateGesture() -> void:
	if holdClick == true: return
	var d := releasePos - pressedPos
	if abs(d.x) > abs(d.y):
		if d.x < 0:
			print("left")
		else:
			print("right")
	else:
		if d.y > 0:
			var tween = get_tree().create_tween()
			tween.tween_property(self,"scroll_vertical", set_next_anchor("up"),0.3).set_ease(Tween.EASE_OUT)
			#set_deferred("scroll_vertical", set_next_anchor("up"))
		else:
			var tween = get_tree().create_tween()
			tween.tween_property(self,"scroll_vertical", set_next_anchor("down"),0.3).set_ease(Tween.EASE_OUT)

func set_next_anchor(direction) -> float:
	
	if("up" == direction):
		if (i != 2):
			i += 1
			var t = (get_viewport_rect().size.y/2) 
			var r = get_node(anchors[i]).position.y
			next_anchor = r - t
	if("down" == direction):
		if (i != 0):
			i -= 1
			next_anchor = get_node(anchors[i]).position.y - (get_viewport_rect().size.y/2)
	return next_anchor
	
