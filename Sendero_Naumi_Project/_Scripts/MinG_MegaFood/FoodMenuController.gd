extends Control

var anchors := []
@export var limitGesture : float
@export var limitHold : float
@export var limitunderHolf : float
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
var StopDrag
var isverticalGesture
signal isScrolling
signal CompleteSwipe
signal PlatesReset
signal RealeaseDragObject
signal aPlateAreDragging
signal aPlateWasDrop

func _ready():
	AddPlatesOnAnchor()
	inputTouch = InputEventScreenTouch.new()
	timer = get_parent().get_node("TimerScroll")
	timer.timeout.connect(calculateGesture)
	position.x = position.x + (get_viewport_rect().size.x/2 - anchors[i].global_position.x)
	enableInteraction()

func AddPlatesOnAnchor():
	anchors.clear()
	for p in get_children():
		if p is Sprite2D and p not in anchors:
			anchors.append(p)

func _input(event: InputEvent) -> void:
	if StopDrag : return
	if event is InputEventScreenTouch:
		if event.index != 0:
			multitouch = true
		else: multitouch = false
	if event is InputEventScreenDrag:
		if event.index != 0:
			multitouch = true
		else: multitouch = false
	
	if Input.is_action_just_pressed("TouchScreen"):
		if multitouch : return
		pressedPos = event.position
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
		
	if Input.is_action_pressed("TouchScreen"):
		if multitouch : return
		var d 
		d = pressedPos - event.position
		if abs(d.x) < abs(d.y):
			isverticalGesture = true
			return
		if isverticalGesture : return
		if actualDrag.x != event.position.x:
			isScrolling.emit()
			position.x = position.x + (event.position.x - actualDrag.x)
			actualDrag.x = event.position.x

func calculateGesture() -> void:
	if isverticalGesture : return
	if !inGesture : return 
	inGesture = false
	if hold : return
	isScrolling.emit()
	var d 
	d= releasePos - pressedPos
	if (abs(d.x) < limitGesture) : 
		next_anchor = position.x + (get_viewport_rect().size.x/2 - anchors[i].global_position.x)
		var tween = get_tree().create_tween()
		tween.tween_property(self,"position", Vector2(next_anchor,position.y),0.15).set_ease(Tween.EASE_OUT)
		return
	if abs(d.x) > abs(d.y):
		if d.x < 0:
			var tween = get_tree().create_tween()
			tween.tween_property(self,"position", Vector2(set_next_anchor("rigth"),position.y),0.2).set_ease(Tween.EASE_OUT)
		else:
			var tween = get_tree().create_tween()
			tween.tween_property(self,"position", Vector2(set_next_anchor("left"),position.y),0.2).set_ease(Tween.EASE_OUT)

func inHold():
	if isverticalGesture : return
	if !hold: return
	if inGesture : return
	var holdVector
	holdVector = pressedPos.x - releasePos.x
	if (abs(holdVector) > limitHold):
		if (holdVector > 0):
			var tween = get_tree().create_tween()
			tween.tween_property(self,"position", Vector2(set_next_anchor("rigth"),position.y),0.2).set_ease(Tween.EASE_OUT)
		elif (holdVector < 0):
			var tween = get_tree().create_tween()
			tween.tween_property(self,"position", Vector2(set_next_anchor("left"),position.y),0.2).set_ease(Tween.EASE_OUT)
	else :
		next_anchor = position.x + (get_viewport_rect().size.x/2 - anchors[i].global_position.x)
		var tween = get_tree().create_tween()
		tween.tween_property(self,"position", Vector2(next_anchor,position.y),0.15).set_ease(Tween.EASE_OUT)

func set_next_anchor(direction):
	if("rigth" == direction):
		if (i != anchors.size()-1):
			i += 1
			next_anchor = position.x + (get_viewport_rect().size.x/2 - anchors[i].global_position.x)
	if("left" == direction):
		if (i != 0):
			i -= 1
			next_anchor = position.x + (get_viewport_rect().size.x/2 - anchors[i].global_position.x)
	enableInteraction()
	CompleteSwipe.emit()
	return next_anchor

func enableInteraction():
	for b in anchors[i].get_children():
		if b is Area2D:
			b.isEnableButton(true)
	if (i < (anchors.size() - 1)):
		for b in anchors[1 + i].get_children():
			if b is Area2D:
				b.isEnableButton(false)
	if (i > 0):
		for b in anchors[i - 1].get_children():
			if b is Area2D:
				b.isEnableButton(false)

func stopDrag(x = true):
	StopDrag = x
	

func Reset():
	for f in get_children():
		f.get_node("DragObject").ResetPosition()
	AddPlatesOnAnchor()
	StopDrag = false

func LockUnklockGragObjects(x):
	for f in get_children():
		f.get_node("DragObject").isEnableButton(x)
	
var plateRef
func ReOrganizePlates():
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
			print(plate.name)
		else:
			if plate == plateRef:
				if indexp == anchors.size()-1:
					var tween = get_tree().create_tween()
					tween.tween_property(self,"position", Vector2(set_next_anchor("left"),position.y),0.2).set_ease(Tween.EASE_OUT)
				else:
					ismiddleplate = true
				indexToRemove = indexp
	anchors.remove_at(indexToRemove)
	enableInteraction()
	PlatesReset.emit()
	StopDrag = false

func ChangeInitPos(plate,platePos):
	plate.get_node("DragObject").lastPosition = platePos
	plate.get_node("DragObject").isEnableButton(false)

func SetPlate(p):
	plateRef = p

func DetectDraggingPlate():
	aPlateAreDragging.emit()

func DetectMouseRelease():
	aPlateWasDrop.emit()
