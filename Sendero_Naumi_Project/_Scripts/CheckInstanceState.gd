extends Control
@export var TranslateAtBeginning : bool
signal InstanceTrue

func _ready():
	get_parent().get_parent().Transitioned.connect(IsInInstance)
	

func IsInInstance():
	if visible == true:
		InstanceTrue.emit()
		if TranslateAtBeginning:
			TranslateToZero()
	else:
		if TranslateAtBeginning:
			position = Vector2(5000,5000)

func TranslateToZero():
	position = Vector2.ZERO
