extends Node2D

@onready var checkTrue = $CheckAllTrue
@onready var anim = $AnimationPlayer
@onready var rocas = get_parent().get_node("Rocas")
@export var DoAnim : bool

func _ready():
	for i in checkTrue.get_children():
		i.AllSpots.connect(DoDiscoverAnim.bind(i))
	#checkTrue.AllTrue.connect(DoDiscoverAnim)

func DoDiscoverAnim(x):
	#rocas.get_node("colliders").queue_free()
	x.get_node("particles").Emit()
	#anim.play("Skeleton_Discover")
	x.z_index = 2

