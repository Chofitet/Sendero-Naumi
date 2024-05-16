extends Node2D

@export var minDistance : Node2D
@export var maxDistance : Node2D
@export var player : CharacterBody2D
@onready var canvas_modulate = $CanvasModulate
@onready var exterior = $exterior
@onready var anchor = $Anchor
@onready var capsule = $Capsula
var _isOut

func _ready():
	canvas_modulate.color = Color(0,0,0,1)
	pass

func _process(delta):
	if _isOut: return
	DawnSpace(get_increaser())

func get_increaser() -> float:
	var PlayerPos = player.global_position.y
	var distant_anchor = 0
	if(PlayerPos < minDistance.global_position.y and PlayerPos > maxDistance.global_position.y):
		var factor_interpolacion = (PlayerPos - minDistance.global_position.y) / (maxDistance.global_position.y - minDistance.global_position.y)
		distant_anchor = lerp(0, 1, factor_interpolacion)
	elif ( PlayerPos < maxDistance.global_position.y):
		distant_anchor = 1
	return distant_anchor

func DawnSpace(x):
	canvas_modulate.color = Color(x,x,x,1)
	exterior.self_modulate = Color(1,1,1,x)

func IsOut():
	$interior.material = null
	exterior.self_modulate = Color(1,1,1,1)
	_isOut = true
