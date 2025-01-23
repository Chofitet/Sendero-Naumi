extends Control

var WinnedMedal = preload("res://Sprites/ZonaGeología/medal - RockFighter.png")

func AddWinnedMedal(num : int):
	match num:
		2: 
			$HBoxContainer/medal1.texture = WinnedMedal
		3:
			$HBoxContainer/medal1.texture = WinnedMedal
			$HBoxContainer/medal2.texture = WinnedMedal

