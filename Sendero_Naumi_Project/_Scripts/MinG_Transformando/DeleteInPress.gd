extends Button


func _ready():
	pressed.connect(OnPress)

func OnPress():
	queue_free()
