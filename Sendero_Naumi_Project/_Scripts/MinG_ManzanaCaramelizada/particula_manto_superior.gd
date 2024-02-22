extends RigidBody2D
@onready var raycast : RayCast2D = $RayCast2D 
var isInPlace

func _init():
	apply_impulse(Vector2(-100,600))
	rotation = randf_range(0,360)

func _process(delta):
	if isInPlace : return
	if !raycast.get_collider() : return
	var _collider = raycast.get_collider()
	if _collider.is_in_group("apple2"):
		_collider.Set_Complete()
		call_deferred("set_freeze")
		global_position = _collider.global_position
		isInPlace = true


func set_freeze():
	freeze = true 
