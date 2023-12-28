extends Sprite2D

var viewport_size_x
var viewport_size_y
var initScale
@export var duration : float
var anim 
func _ready():
	initScale = scale
	anim = get_node("AnimationPlayer")
	viewport_size_x = get_viewport_rect().size.x
	viewport_size_y= get_viewport_rect().size.y
	MoveMap()

func MoveMap():
	var tween = get_tree().create_tween()
	tween.finished.connect(AnimArrive)
	tween.tween_property(self, "position", Vector2(viewport_size_x/2,viewport_size_y-400),duration)
	var tweenS = get_tree().create_tween()
	tweenS.tween_property(self, "scale", initScale * 1.8 ,duration)

func AnimArrive():
	var tweenS = get_tree().create_tween()
	tweenS.tween_property(self, "scale", scale * 2 ,1).set_ease(Tween.EASE_IN_OUT)
	anim.play("map_arrive_anim")
