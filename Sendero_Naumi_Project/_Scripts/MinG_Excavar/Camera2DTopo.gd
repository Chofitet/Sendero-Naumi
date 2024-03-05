extends Camera2D
var onAreaUp
var onAreaDown
var DoCam = true
@export var topo : Node2D

func _ready():
		RestartPos()
		offset = Vector2(get_viewport_rect().size.x/2,get_viewport_rect().size.y/2)

func _process(delta):
	if !DoCam : return
	
	if onAreaDown:
		offset.y = get_viewport_rect().size.y/2 + (topo.global_position.y - get_viewport_rect().size.y/2 - topo.get_node("Area2D/CollisionShape2D").shape.radius/2)	

func SetOnAreaUp(shape,x):
	if !shape.is_in_group("topo"): return
	onAreaUp = x

func SetOnAreaDown(shape,x):
	if !shape.is_in_group("topo"): return
	onAreaDown = x

func RestartPos():
	onAreaUp = false
	onAreaDown = false
	offset = Vector2(get_viewport_rect().size.x/2,get_viewport_rect().size.y/2)
	print(offset)
