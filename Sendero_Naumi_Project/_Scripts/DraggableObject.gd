extends Area2D

var pick_up = false
var object 
var is_in_spot = false
var initial_spot
var isInPosition
var AskSpot
@export var spot : Area2D
@export var holdTime : float
@export var DesapearInPlace : bool
@export var notCenterObject : bool
@export var LimitCircleArea : bool
@export var MaxRadiusClamp : float
@export var LimitRectangleArea : bool
@export var BoundsRectangleClamp : Vector2
var timerHold
var isInTime
var GrabOffset : Vector2
signal isDraggin
signal mouse_realese

func _ready():
	timerHold = $Timer
	timerHold.wait_time = holdTime
	$Button.button_down.connect(_on_button_pressed)
	timerHold.timeout.connect(TimeToDrag)
	object = get_parent()
	initial_spot = object.position
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
	await  mouse_realese
	isInTime = false
	pick_up = false
	if !spot: return
	CheckRightSpot()
	if (is_in_spot):
		if DesapearInPlace: object.visible = false
		var tween = get_tree().create_tween()
		tween = tween.tween_property(object, "global_position",spot.global_position,0.1).set_ease(Tween.EASE_OUT)
		isInPosition = true
	else: 
		CancelDrag(object)
	
func GetSpot(x):
	AskSpot = x
	
func deleteSpot(x):
	AskSpot = null

func CheckRightSpot():
	if (AskSpot == spot):
		is_in_spot = true
	else: is_in_spot = false

func CancelDrag(x):
	if timerHold.timeout.is_connected(TimeToDrag):
		timerHold.timeout.disconnect(TimeToDrag)
	var tween = get_tree().create_tween()
	tween = tween.tween_property(object, "position",initial_spot,0.1).set_ease(Tween.EASE_OUT)
	isInPosition = false

func TimeToDrag():
	var tween = get_tree().create_tween()
	#tween = tween.tween_property(object, "global_position",get_global_mouse_position(),0.1).set_ease(Tween.EASE_OUT)
	await tween
	isInTime = true
	isDraggin.emit()

func isEnableButton(x):
	if x:
		$Button.visible = true
	else: $Button.visible = false

func ResetPosition():
	object.visible = true
	object.position = initial_spot
	isInPosition = false
	is_in_spot = false

func CalculateGrabOffset():
	GrabOffset = abs(object.global_position - get_global_mouse_position())
