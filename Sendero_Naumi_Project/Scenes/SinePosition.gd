extends Node2D

@export var StartOnBeginning : bool
@export var amplitude: float = 50.0  # Amplitud de la oscilación
@export var frequency: float = 1.0   # Frecuencia de la oscilación

var _time: float = 0.0
var _origin_position: Vector2

func _ready():
	_origin_position = position
	if StartOnBeginning:
		StartMove()

func StartMove():
	set_process(true)

func _process(delta):
	SineFunction(delta)

func SineFunction(delta):
	_time += delta
	position = _origin_position + Vector2(0, sin(_time * frequency * TAU) * amplitude)

func Stop():
	set_process(false)
