extends ScrollContainer

@export var limit : float
@export var anchors := []
var i = 0
var pressedPos : Vector2
var releasePos : Vector2
var timer 
var holdClick
var next_anchor 
signal stopHold
var inGesture
var isInputBlock
var actualAnchor

func _ready():
	actualAnchor = anchors[0]
	timer = get_parent().get_node("TimerScroll")
	timer.timeout.connect(calculateGesture)
	set_deferred("scroll_vertical",next_anchor)
	var y = get_node(anchors[i]).global_position.y 
	next_anchor = getAnchorInBackScreen()
	set_deferred("scroll_vertical",next_anchor)
	stopHold.connect(HoldingClick)

func _input(event: InputEvent) -> void:
	if isInputBlock: return
	if Input.is_action_just_pressed("TouchScreen"):
		pressedPos = event.position
		timer.start()
		holdClick = true
		inGesture = true
		
	if Input.is_action_just_released("TouchScreen"):
		releasePos = event.position
		holdClick = false
		stopHold.emit()

func HoldingClick():
	if inGesture : return
	var tween = get_tree().create_tween()
	var auxNextAnchor = find_closest_node(true)
	if get_node(actualAnchor) != auxNextAnchor: SoundManager.play("map","hold")
	tween.tween_property(self,"scroll_vertical", find_closest_node().position.y - (get_viewport_rect().size.y/2) ,0.3).set_ease(Tween.EASE_IN_OUT)

func calculateGesture() -> void:
	inGesture = false
	if holdClick: return
	var d := releasePos - pressedPos
	if (abs(d.y) < limit) : return
	if abs(d.x) > abs(d.y):
		if d.x < 0:
			print("left")
		else:
			print("right")
	else:
		
		if d.y > 0:
			var tween = get_tree().create_tween()
			tween.tween_property(self,"scroll_vertical", set_next_anchor("up"),0.2).set_ease(Tween.EASE_OUT)
			#set_deferred("scroll_vertical", set_next_anchor("up"))
		else:
			var tween = get_tree().create_tween()
			tween.tween_property(self,"scroll_vertical", set_next_anchor("down"),0.2).set_ease(Tween.EASE_OUT)
	
	SetFloorWithAnchor(i)

func set_next_anchor(direction) -> float:
	
	if("up" == direction):
		if (i != 3):
			SoundManager.play("map","swipe")
			i += 1
			var t = (get_viewport_rect().size.y/2) 
			var r = get_node(anchors[i]).position.y
			next_anchor = r - t
	if("down" == direction):
		if (i != 0):
			SoundManager.play("map","swipe")
			i -= 1
			next_anchor = get_node(anchors[i]).position.y - (get_viewport_rect().size.y/2)
	return next_anchor

func find_closest_node(notSet: bool = false):
	var closest_node : Control = null
	var min_distance = 5000
	var centerScreen = Vector2(0, scroll_vertical + (get_viewport_rect().size.y/2))
	
	for n in anchors:
		var node = get_node(n)
		var distance = abs(centerScreen.distance_to(node.position))
		var distannedo = node.position

		if distance < min_distance:
			min_distance = distance
			closest_node = node
			
		if !notSet:
			if closest_node.name == "Piso1":
				SetFloorWithAnchor(0)
			elif closest_node.name == "Piso2":
				SetFloorWithAnchor(1)
			elif closest_node.name == "Piso3":
				SetFloorWithAnchor(2)
			elif closest_node.name == "Piso4":
				SetFloorWithAnchor(3)
	return closest_node

func getAnchorInBackScreen() -> float:
	var NumPiso = PlayerVariables.NumPiso
	if NumPiso == 1:
		SetFloorWithAnchor(0)
		return get_viewport_rect().size.y * 4
	if NumPiso == 2:
		SetFloorWithAnchor(1)
		return get_viewport_rect().size.y * 2 - get_viewport_rect().size.y/3
	if NumPiso == 3:
		SetFloorWithAnchor(2)
		return get_viewport_rect().size.y - get_viewport_rect().size.y/5
	if NumPiso == 4:
		SetFloorWithAnchor(3)
		return 0
	return get_viewport_rect().size.y * 4

func SetisInputBlock(x):
	isInputBlock = !x

func SetFloorWithAnchor(num):
	i = num
	PlayerVariables.SaveLastPiso(num + 1)
	actualAnchor = anchors[i]
	await get_tree().create_timer(0.2).timeout
	$FloorDetector.SetActualFloor(num)
