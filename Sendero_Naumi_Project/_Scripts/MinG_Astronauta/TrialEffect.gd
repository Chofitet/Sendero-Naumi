extends Line2D

var queue : Array
@export var Max_Size : float = 200
var isStoped
var pos
@onready var incruse = width 
@onready var incruse2 = Max_Size

func _process(delta):
	if !isStoped:
		pos = get_parent().position
	
	if isStoped and incruse >= 0:
		incruse -= delta * 80
		width = incruse
	
	queue.push_front(pos)
	
	if queue.size() > Max_Size or isStoped:
		queue.pop_back()
		if isStoped:
			queue.pop_back()
	
	clear_points()
	
	for point in queue:
		add_point(point)

func StopLine():
	isStoped = true
	
