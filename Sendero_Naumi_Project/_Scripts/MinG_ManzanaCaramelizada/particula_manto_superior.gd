extends RigidBody2D
@onready var raycast : RayCast2D = $RayCast2D 
var isOverlaping

func _init():
	apply_impulse(Vector2(0,400))
	rotation = randf_range(0,360)

func _process(delta):
	if !raycast.get_collider() : return
	if raycast.get_collider().is_in_group("apple2"):
		if raycast.get_collider().isComplete : return
		raycast.get_collider().Set_Complete()
		call_deferred("set_freeze")
		

func set_freeze():
	freeze = true 
