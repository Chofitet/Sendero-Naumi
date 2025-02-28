extends Label

@export var pencil : Node2D

func _ready():
	size = Vector2(size.x,0)
	
func _process(delta):
	if pencil == null : return
	if abs(pencil.global_position.y - global_position.y) < 3:
		var tween = get_tree().create_tween()
		tween.tween_property(self,"size",Vector2(size.x,250),1)

func SetPencil(x):
	pencil = x
