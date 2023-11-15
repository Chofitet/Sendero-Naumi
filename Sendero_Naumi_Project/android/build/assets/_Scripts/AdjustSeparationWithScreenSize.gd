extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	add_theme_constant_override("Separation", get_viewport_rect().size.y) 
