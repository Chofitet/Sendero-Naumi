extends TextureRect
var NaumiStates = [load("res://Sprites/Naumi/Naumi_0.png"),
load("res://Sprites/Naumi/Naumi_1.png"),
load("res://Sprites/Naumi/Naumi_02.png")]
var currentState = 0

func _on_tree_entered():
	if currentState != PlayerVariables.NaumiLevel :
		get_node("AnimationPlayer").play("to_level_up")

func _on_button_pressed():
		currentState = PlayerVariables.NaumiLevel
		texture = NaumiStates[currentState]
		get_node("AnimationPlayer").stop()
