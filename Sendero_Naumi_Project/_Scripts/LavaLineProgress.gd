extends Line2D

@export var Lava : Sprite2D
var isDrawing
var i = 0

func _physics_process(delta):
	if isDrawing:
		var relative_position = Lava.global_position - global_position
		add_point(relative_position)
		var ArrayPoints = get_points( )
		i = ArrayPoints.size()
	else:
		if i > 0:
			remove_point(i)
			i -= 1


func _on_tap_button_down():
	isDrawing = true

func _on_tap_button_up():
	isDrawing = false
