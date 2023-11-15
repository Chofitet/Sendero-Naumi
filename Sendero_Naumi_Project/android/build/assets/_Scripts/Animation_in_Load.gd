extends AnimationPlayer
@export var animation : String

func _ready():
	play(animation)
