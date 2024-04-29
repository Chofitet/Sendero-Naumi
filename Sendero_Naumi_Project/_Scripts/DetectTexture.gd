extends Button
@export var threshold : float
var realeasePos
var pressedPosition
signal Left 
signal Right
signal Up
signal Down
signal NoGesture
var btnIsPressed

func _ready():
	button_down.connect(CheckButtonPress)

func _input(event:InputEvent):
	if Input.is_action_just_pressed("TouchScreen"):
		pressedPosition = event.position
	if Input.is_action_just_released("TouchScreen"):
		realeasePos = event.position
		CalculateGesture()
		pressedPosition = event.position
		btnIsPressed = false

func CalculateGesture():
	if !btnIsPressed: return
	var d = realeasePos - pressedPosition
	if abs(d.x) < threshold:
		if abs(d.x) > abs(d.y):
		#left or right
			if d.x < 0:
				Left.emit()
			else:
				Right.emit()
		else:
		#up or down
			if d.y > 0:
				Down.emit()
			else:
				Up.emit()

func CheckButtonPress():
	btnIsPressed = true
