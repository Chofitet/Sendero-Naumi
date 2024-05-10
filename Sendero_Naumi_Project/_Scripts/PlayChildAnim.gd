extends Node2D
@export var Anim : String
@export var awaitTimeBetween : float

func PlayAnimChild():
	for c in get_children():
		if c is AnimationPlayer:
			c.play(Anim)
		else:
			for subc in c.get_children():
				await get_tree().create_timer(awaitTimeBetween).timeout
				if subc is AnimationPlayer:
					subc.play(Anim)

func Set_Anim(anim):
	Anim = anim
