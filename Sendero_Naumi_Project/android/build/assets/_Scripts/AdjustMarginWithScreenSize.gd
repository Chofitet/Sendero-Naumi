extends MarginContainer
@export var margin : String

# Called when the node enters the scene tree for the first time.
func _ready():
	add_theme_constant_override(margin, get_viewport_rect().size.y/2) 
