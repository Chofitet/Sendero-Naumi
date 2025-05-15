extends TextureRect

func _ready():
	print(name)
	if get_viewport_rect().size.y < 1500:
		scale = Vector2(0.95,0.95)
