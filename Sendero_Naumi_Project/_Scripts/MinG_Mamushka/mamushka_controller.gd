extends Node2D
var state = 0 
var SpriteLayers :=[]

func _ready():
	for l in $Sprites.get_children():
		SpriteLayers.append(l)
		l.visible = false
		SpriteLayers[0].visible = true

func AddLayer():
	state += 1
	SpriteLayers[state].visible = true

func CheckRight() -> int:
	return state
