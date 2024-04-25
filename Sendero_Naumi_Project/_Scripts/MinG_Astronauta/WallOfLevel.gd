extends StaticBody2D
@export var isUp : bool

func Set_Collider_Position(x):
	if !x.is_in_group("Player"): return
	position.x = 0
	position.y = -get_viewport_rect().size.y/2 * 5
	if !isUp:
		position.y = get_viewport_rect().size.y/2 * 5
		

func SetActiveCollision():
	position.x = 5710
