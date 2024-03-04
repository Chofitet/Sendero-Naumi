extends Node2D

@onready var checkTrue = $CheckAllTrue
@onready var anim = $AnimationPlayer
@onready var rocas = get_parent().get_node("Rocas")
@export var DoAnim : bool
signal SkeletonDiscover

func _ready():
	for i in checkTrue.get_children():
		i.AllSpots.connect(DoDiscoverAnim.bind(i))
	#checkTrue.AllTrue.connect(DoDiscoverAnim)

func DoDiscoverAnim(x):
	x.get_node("particles").Emit()
	x.z_index = 2
	var initScale = x.scale
	var tween = get_tree().create_tween()
	tween.tween_property(x,"scale",initScale*1.15,0.3).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(x,"scale",initScale,0.3).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	SkeletonDiscover.emit()
