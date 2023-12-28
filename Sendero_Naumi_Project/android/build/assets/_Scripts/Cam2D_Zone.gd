extends Camera2D

var current_zoom
var min_zoom
var max_zoom
var zoom_factor = 0.75 # < 1 = zoom_in; > 1 = zoom_out
var transition_time = 0.25
@export var ZoomVector : Vector2
var defaultZoom

func _ready():
	defaultZoom = Vector2(zoom.x,zoom.y)
	#max_zoom = zoom.x
	#min_zoom = max_zoom * zoom_factor

func zoom_in(new_offset):
	transition_camera(ZoomVector)
	Transition_Offset(new_offset)


func zoom_out(new_offset):
	transition_camera(defaultZoom)
	Transition_Offset(new_offset)


func transition_camera(new_zoom):
	var tween = get_tree().create_tween()
	if new_zoom != current_zoom:
		current_zoom = new_zoom
		tween.tween_property(self,"zoom",new_zoom,transition_time).set_trans(Tween.TRANS_LINEAR).set_ease(tween.EASE_IN_OUT)
		

func Transition_Offset(new_offset):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "offset", new_offset,transition_time).set_trans(Tween.TRANS_LINEAR).set_ease(tween.EASE_IN_OUT)
