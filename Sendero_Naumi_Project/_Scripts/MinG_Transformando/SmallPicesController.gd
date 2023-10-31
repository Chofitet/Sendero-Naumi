extends RigidBody2D

func _ready():
	get_node("Timer").timeout.connect(Freeze)
	get_node("Timer").start()

func Freeze():
	freeze = true
