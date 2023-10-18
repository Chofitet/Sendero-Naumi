extends Sprite2D

var NaumiStates = [load("res://Sprites/Naumi/Naumi_0.png"),
load("res://Sprites/Naumi/Naumi_1.png"),
load("res://Sprites/Naumi/Naumi_02.png")]
var currentState = 0

func _ready():
	position = get_viewport_rect().size/2
	currentState = PlayerVariables.NaumiLevel
	texture = NaumiStates[currentState]

