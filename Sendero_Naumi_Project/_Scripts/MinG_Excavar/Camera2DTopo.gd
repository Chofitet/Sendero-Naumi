extends Camera2D
var onAreaUp
var onAreaDown
var DoCam = true

@export var topo : Node2D

func _ready():
		offset.x = get_viewport_rect().size.x/2
		offset.y = get_viewport_rect().size.y/2
#		if get_viewport_rect().size.y < 2000:
#			DoCam = false
			

func _process(delta):
	if !DoCam : return
	var tween = get_tree().create_tween()
	if onAreaUp:
		var a = get_viewport_rect().size.y/2 + topo.global_position.y - 260
		tween.tween_property(self,"offset", Vector2(offset.x,a),0.2)
	
	if onAreaDown:
		var a = get_viewport_rect().size.y/2 + (topo.global_position.y - get_viewport_rect().size.y/2 - topo.get_node("Area2D/CollisionShape2D").shape.radius/2)
		tween.tween_property(self,"offset", Vector2(offset.x,a),0.2)
	

func SetOnAreaUp(shape,x):
	if !shape.is_in_group("topo"): return
	onAreaUp = x

func SetOnAreaDown(shape,x):
	if !shape.is_in_group("topo"): return
	onAreaDown = x

