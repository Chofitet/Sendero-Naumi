extends ColorRect

@export var y : int
@export var hasSizeOffset : bool
var timer 
var initialpos

func _ready():
	timer = get_node("Timer")
	timer.timeout.connect(AnimBack)
	initialpos = position

func Anim():
	var Sizeoffset
	if hasSizeOffset: Sizeoffset = size.y
	else: Sizeoffset=0
	timer.start()
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position", Vector2(position.x,get_viewport_rect().size.y/2 + get_viewport_rect().size.y/20 - Sizeoffset + y), 0.5 )

func AnimBack():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position", initialpos,0.5)
