extends Sprite2D

var NaumiStates = [load("res://Sprites/Naumi/Naumi_0.png"),
load("res://Sprites/Naumi/Naumi_1.png"),
load("res://Sprites/Naumi/Naumi_02.png")]
var currentState = 0

func _ready():
	currentState = PlayerVariables.NaumiLevel
	position = get_viewport_rect().size/2
	texture = NaumiStates[currentState - 1]
	get_node("ButtonChangeContinue").visible = false
	get_node("AnimationPlayer").play("to_level_up")

func _on_button_pressed():
	get_node("ButtonChangeContinue").visible = true
	texture = NaumiStates[currentState]
	get_node("AnimationPlayer").stop()

