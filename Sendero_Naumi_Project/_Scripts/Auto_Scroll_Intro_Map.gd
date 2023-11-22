extends ScrollContainer
var view_port_size_x 
var view_port_size_y
@export var scrollDuration : float

func _ready():
	view_port_size_x = get_viewport_rect().size.x
	view_port_size_y = get_viewport_rect().size.y
	ScrollScreen()

func ScrollScreen():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"scroll_vertical", Vector2(view_port_size_x,view_port_size_x*4),scrollDuration)
