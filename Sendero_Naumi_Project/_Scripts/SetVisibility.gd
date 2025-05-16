extends Sprite2D
@export var boolean : bool

func Setvisivility(x):
	if x is bool: visible = x
	else:
		visible = boolean
