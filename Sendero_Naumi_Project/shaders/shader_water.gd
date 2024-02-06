extends Line2D
var arrivalPoint 
var speed : float
var incruse : float = 0
var inPressed = false
var auxbool = false
signal toBathe
signal stopBathe
var once

func init(btn,_speed):
	arrivalPoint = $ArrivalPoint
	inPressed = true
	btn.button_up.connect(Button_Up)
	speed = _speed
	auxbool = true
	
#Connect the item_rect_changed() signal to this function
func _on_Waterfall_item_rect_changed():
	get_material().set_shader_parameter("scale", scale)

func _on_change_texture(x):
	get_material().set_shader_parameter("scale", Vector2(x,scale.y))

func Speed(x):
	get_material().set_shader_parameter("speed", x)

	
func Button_Up():
	inPressed = false
	
func _process(delta):
	get_material().set_shader_parameter("zoom", get_viewport_transform().y.y)
	if auxbool:
		if incruse < arrivalPoint.position.y:
			incruse += delta * speed
			var point = Vector2(0, incruse)
			add_point(point)
			#_on_change_texture(clamp((incruse / 314),0,1))
		else:
			toBathe.emit()
	if !inPressed:
		if get_point_count() != 0:
			remove_point(0)
		else:
			stopBathe.emit()
			queue_free()
