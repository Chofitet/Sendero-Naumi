extends TextureRect
var NaumiStates = [load("res://Sprites/Naumi/Naumi_0.png"),
load("res://Sprites/Naumi/Naumi_1.png"),
load("res://Sprites/Naumi/Naumi_02.png")]

func _on_tree_entered():
	var state = PlayerVariables.NaumiLevel
	texture = NaumiStates[state]
	
