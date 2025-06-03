extends Control

var anchors := []
@export var limitGesture : float
@export var limitHold : float
@export var limitunderHolf : float
@export var ResetPlatesIndex : bool
var timer
var pressedPos
var inGesture
var releasePos
var i = 1
var next_anchor
var hold
var actualDrag : Vector2
var inputTouch
var multitouch
var StopDrag = true
var isverticalGesture
var isHorizontalGesture
signal isScrolling
signal CompleteSwipe
signal PlatesReset
signal RealeaseDragObject
signal aPlateAreDragging
signal aPlateWasDrop
signal ServePlate
var TouchBegginInArea
var isInTutorial
var isFirstTouch = false
var stopScroll = false
func _ready():
	AddPlatesOnAnchor()
	inputTouch = InputEventScreenTouch.new()
	timer = get_parent().get_node("TimerScroll")
	timer.timeout.connect(CalculateVerticalGesture)
	timer.timeout.connect(calculateGesture)
	position.x = position.x + (get_viewport_rect().size.x/2 - anchors[i].global_position.x)


func AddPlatesOnAnchor():
	anchors.clear()
	for p in get_children():
		if p is Sprite2D and p not in anchors:
			anchors.append(p)

var last_touch_pos = Vector2()

var realInput : Vector2

func _input(event: InputEvent) -> void:
	if StopDrag : return
	
	if event != null: realInput = event.position
	
	if event is InputEventScreenTouch:
		if event.index != 0:
			multitouch = true
		else: multitouch = false
	if event is InputEventScreenDrag:
		if event.index != 0:
			multitouch = true
		else: multitouch = false
	
	if Input.is_action_just_pressed("TouchScreen"):
		if not get_global_rect().has_point(event.position):return
		if multitouch : return
		pressedPos = event.position
		isFirstTouch = true
		actualDrag = pressedPos
		timer.start()
		inGesture = true
		hold = true
		
	if Input.is_action_just_released("TouchScreen"):
		if multitouch : return
		RealeaseDragObject.emit()
		releasePos = event.position
		inHold()
		hold = false
		isverticalGesture = false
		isHorizontalGesture = false
		
	if Input.is_action_pressed("TouchScreen"):
		if multitouch : return
		var d 
		if pressedPos == null : return
		if !hold : return
		d = pressedPos - event.position
		if not get_global_rect().has_point(event.position) : inGesture = false
		if abs(d.x) < abs(d.y):
			isverticalGesture = true
			if isFirstTouch: return
		elif abs(d.x) > abs(d.y):
			isHorizontalGesture = true
		if isDraggingAPplate: return
		if stopScroll: return
		if actualDrag.x != event.position.x:
			var delta_x = event.position.x - actualDrag.x
			if is_at_left_limit and delta_x < 0:
				return
			if is_at_right_limit and delta_x > 0:
				return
			var target_x = position.x + delta_x
			if isFirstTouch: position.x = lerp(position.x, target_x, 0.15)
			else: position.x = target_x
			isScrolling.emit()
			
			
			actualDrag.x = event.position.x

func calculateGesture() -> void:
	isFirstTouch = false
	if isverticalGesture : return
	if !inGesture : return
	if isVerticalSwipe: return
	inGesture = false
	if hold : return
	isScrolling.emit()
	print("horizontalSwipe")
	var d 
	d= releasePos - pressedPos
	if (abs(d.x) < limitGesture) :
		next_anchor = position.x + (get_viewport_rect().size.x/2 - anchors[i].global_position.x)
		var tween = get_tree().create_tween()
		tween.tween_property(self,"position", Vector2(next_anchor,position.y),0.15).set_ease(Tween.EASE_IN_OUT)
		return
	if abs(d.x) > abs(d.y):
		if d.x < 0:
			var tween = get_tree().create_tween()
			tween.tween_property(self,"position", Vector2(set_next_anchor("rigth"),position.y),0.2).set_ease(Tween.EASE_OUT)
		else:
			var tween = get_tree().create_tween()
			tween.tween_property(self,"position", Vector2(set_next_anchor("left"),position.y),0.2).set_ease(Tween.EASE_OUT)

var isVerticalSwipe = false

var last_real_input := Vector2.ZERO
var velocity_input := 0.0

func _process(delta):
	var delta_input = abs(realInput - last_real_input)
	velocity_input = delta_input.length() / delta
	last_real_input = realInput

func CalculateVerticalGesture():
	isFirstTouch = false
	if isInTutorial : return
	if isHorizontalGesture : return
	if hold : return
	var d 
	d= releasePos - pressedPos
	if abs(d.x) < abs(d.y):
		if d.y < 0:
			print("verticalSwipe")
			isVerticalSwipe = true
			stopDrag()
			SoundManager.play("DragObject","swipe") 
			anchors[i].get_node("DragObject").PlaceInRightSpot(true)

func inHold():
	if !hold: return
	if inGesture : return
	if isDraggingAPplate : return
	if isVerticalSwipe : return
	print("hold")
	var holdVector
	holdVector = pressedPos.x - releasePos.x
	if abs(holdVector) < abs(pressedPos.y - releasePos.y) and isFirstTouch: return
	if (abs(holdVector) > limitHold):
		if (holdVector > 0):
			var tween = get_tree().create_tween()
			tween.tween_property(self,"position", Vector2(set_next_anchor("rigth"),position.y),0.25).set_ease(Tween.EASE_OUT)
		elif (holdVector < 0):
			var tween = get_tree().create_tween()
			tween.tween_property(self,"position", Vector2(set_next_anchor("left"),position.y),0.25).set_ease(Tween.EASE_OUT)
	else :
		next_anchor = position.x + (get_viewport_rect().size.x/2 - anchors[i].global_position.x)
		var tween = get_tree().create_tween()
		tween.tween_property(self,"position", Vector2(next_anchor,position.y),0.15).set_ease(Tween.EASE_OUT)

func set_next_anchor(direction):
	if("rigth" == direction):
		if (i != anchors.size()-1):
			i += 1
			next_anchor = position.x + (get_viewport_rect().size.x/2 - anchors[i].global_position.x)
			SoundManager.play("DragObject", "swipe")
	if("left" == direction):
		if (i != 0):
			i -= 1
			next_anchor = position.x + (get_viewport_rect().size.x/2 - anchors[i].global_position.x)
			SoundManager.play("DragObject", "swipe")
	enableInteraction()
	disableDetectors()
	CompleteSwipe.emit()
	SetTutorial(false)
	return next_anchor

func enableInteraction():
	for b in anchors[i].get_children():
		if b.has_method("isEnableButton"):
			b.isEnableButton(true)
	if (i < (anchors.size() - 1)):
		for b in anchors[1 + i].get_children():
			if b.has_method("isEnableButton"):
				b.isEnableButton(false)
	if (i > 0):
		for b in anchors[i - 1].get_children():
			if b.has_method("isEnableButton"):
				b.isEnableButton(false)

func disableDetectors():
	for d in anchors:
		d.get_node("detector").get_child(0).disabled = true
		
	anchors[i].get_node("detector").get_child(0).disabled = false

func stopDrag(x = true):
	StopDrag = x
	

func Reset():
	for f in get_children():
		f.get_node("DragObject").ResetPosition()
	AddPlatesOnAnchor()
	StopDrag = false
	stopScroll = false
	isVerticalSwipe = false
	if ResetPlatesIndex:
		i = 1
		plateRef = anchors[1]
	DetectMouseRelease()
	enableInteraction()

func LockUnklockGragObjects(x,justActualPlate = false):
	for f in get_children():
		if justActualPlate:
			anchors[i].get_node("DragObject").isEnableButton(x)
			return
		f.get_node("DragObject").isEnableButton(x)
		
var plateRef
func ReOrganizePlates():
	stopDrag(false)
	isVerticalSwipe = false
	var ismiddleplate = false
	var indexToRemove
	LockUnklockGragObjects(true)
	for plate in anchors:
		var indexp = anchors.find(plate)
		if ismiddleplate:
			var tween = get_tree().create_tween()
			var target_x = plate.position.x - abs(anchors[0].position.x - anchors[1].position.x)
			tween.tween_property(plate,"position", Vector2(target_x,plate.position.y),0.2).set_ease(Tween.EASE_OUT)
			ChangeInitPos(plate,Vector2(target_x,plate.position.y))
		else:
			if plate == plateRef:
				if indexp == anchors.size()-1:
					var tween = get_tree().create_tween()
					tween.tween_property(self,"position", Vector2(set_next_anchor("left"),position.y),0.2).set_ease(Tween.EASE_OUT)
				else:
					ismiddleplate = true
				indexToRemove = indexp
	if indexToRemove == null : return
	anchors.remove_at(indexToRemove)
	if anchors.size() == 1 : stopScroll = true
	enableInteraction()
	PlatesReset.emit()
	StopDrag = false

func ChangeInitPos(plate,platePos):
	plate.get_node("DragObject").lastPosition = platePos
	plate.get_node("DragObject").isEnableButton(false)

func SetPlate(p):
	plateRef = p

var isDraggingAPplate
func DetectDraggingPlate():
	aPlateAreDragging.emit()
	isDraggingAPplate = true

func DetectMouseRelease():
	aPlateWasDrop.emit()
	isDraggingAPplate = false

func SetTutorial(x):
	isInTutorial = x

var is_at_left_limit = false
var is_at_right_limit = false

func ClampRightLimit(x):
	is_at_right_limit = x

func ClampLeftLimit(x):
	is_at_left_limit = x
