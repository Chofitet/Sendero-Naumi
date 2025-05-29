extends Control
signal rightCollision
signal leftCollision

func _ready():
	$RightDetector.area_entered.connect(RightCollision.bind(true))
	$LeftDetector.area_entered.connect(LeftCollision.bind(true))
	$RightDetector.area_exited.connect(RightCollision.bind(false))
	$LeftDetector.area_exited.connect(LeftCollision.bind(false))

func RightCollision(body,x):
	if body.is_in_group(("dragObject")):
		rightCollision.emit(x)

func LeftCollision(body,x):
	if body.is_in_group(("dragObject")):
		leftCollision.emit(x)
