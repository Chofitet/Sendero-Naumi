extends Area2D

var pick_up = false
var object 
var is_in_spot = false
var initial_spot
var isInPosition
var lastPosition
var AskSpot
@export var spot : Area2D
@export var PlaceInAllSpots : bool
@export var holdTime : float
@export var DesapearInPlace : bool
@export var notCenterObject : bool
@export var LimitCircleArea : bool
@export var MaxRadiusClamp : float
@export var LimitRectangleArea : bool
@export var BoundsRectangleClamp : Vector2
@export var tweenTime : float = 0.1
@export var DragSound : String
@export var TapSound : String
var timerHold
var isInTime
var GrabOffset : Vector2
signal isDraggin
signal mouse_realese
signal object_realese_Rigth_Place
signal object_realese_Wrong_Place
signal BackToInitialPos
signal ArriveToSpot

func _ready():
	timerHold = $Timer
	timerHold.wait_time = holdTime
	$Button.button_down.connect(_on_button_pressed)
	timerHold.timeout.connect(TimeToDrag)
	object = get_parent()
	initial_spot = object.position
	lastPosition = initial_spot
	area_entered.connect(GetSpot)
	area_exited.connect(deleteSpot)


func _process(delta):
	if pick_up == true and isInTime:
		if notCenterObject:
			object.global_position = get_global_mouse_position() - GrabOffset
		else: 
			object.global_position = get_global_mouse_position()
		if LimitCircleArea:
			var distance_to_center = object.global_position.distance_to(initial_spot)
			if distance_to_center > MaxRadiusClamp:
				var direction_to_center = (object.global_position - initial_spot).normalized()
				object.global_position = initial_spot + direction_to_center * MaxRadiusClamp
		if LimitRectangleArea:
			var relative_position = object.global_position - initial_spot
			var clamped_position = relative_position.clamp(-BoundsRectangleClamp, BoundsRectangleClamp)
			object.global_position = initial_spot + clamped_position
	if Input.is_action_just_released("TouchScreen"):
		mouse_realese.emit()
	
func _on_button_pressed():
	timerHold.timeout.connect(TimeToDrag)
	CalculateGrabOffset()
	pick_up = true
	timerHold.start()
	SoundManager.play("DragObject", "tap")
	await  mouse_realese
	isInTime = false
	pick_up = false
	if !PlaceInAllSpots:
		if !spot: return
		
		PlaceInRightSpot()
	else:
		
		PlaceInSpot()
		

func PlaceInRightSpot(forceSpot = false):
	CheckRightSpot()
	if forceSpot : is_in_spot = true
	if (is_in_spot):
		object_realese_Rigth_Place.emit()
		var tween = get_tree().create_tween()
		tween = tween.tween_property(object, "global_position",spot.global_position,0.1).set_ease(Tween.EASE_OUT)
		isInPosition = true
		await  tween.finished
		spot.CheckAnswer()
		ArriveToSpot.emit()
		SoundManager.play("DragObject", "inPlace")
		if DesapearInPlace: 
			object.visible = false
	else:
		object_realese_Wrong_Place.emit()
		CancelDrag()

func PlaceInSpot():
	if !AskSpot:
		CancelDrag()
		return
	if DesapearInPlace: 
		object.visible = false
	var tween = get_tree().create_tween()
	tween = tween.tween_property(object, "global_position",AskSpot.global_position,0.1).set_ease(Tween.EASE_OUT)
	isInPosition = true

func GetSpot(x):
	if x.is_in_group("spot"):
		AskSpot = x
	
func deleteSpot(x):
	AskSpot = null

func CheckRightSpot():
	if (AskSpot == spot):
		is_in_spot = true
	else: is_in_spot = false

func CancelDrag():
	if timerHold.timeout.is_connected(TimeToDrag):
		timerHold.timeout.disconnect(TimeToDrag)
	var tween = get_tree().create_tween()
	tween = tween.tween_property(object, "position",lastPosition,tweenTime).set_ease(Tween.EASE_OUT)
	isInPosition = false
	await tween.finished
	BackToInitialPos.emit()

func TimeToDrag():
	#SoundManager.play("drag", "drag")
	var tween = get_tree().create_tween()
	#tween = tween.tween_property(object, "global_position",get_global_mouse_position(),0.1).set_ease(Tween.EASE_OUT)
	await tween
	isInTime = true
	isDraggin.emit()

func isEnableButton(x):
	if x:
		$Button.visible = true
		get_node("CollisionShape2D").disabled = false
	else: 
		$Button.visible = false
		get_node("CollisionShape2D").disabled = true

func ResetPosition():
	object.visible = true
	object.position = initial_spot
	lastPosition = initial_spot
	isInPosition = false
	is_in_spot = false

func CalculateGrabOffset():
	GrabOffset = abs(object.global_position - get_global_mouse_position())
