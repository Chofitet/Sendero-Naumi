extends Area2D

func _ready():
	area_entered.connect(Destroy)

func Destroy(x):
	x.get_parent().queue_free()
