extends TextureRect
var completeZone 
@export var NumOfMinigame : int

#func _on_btn_zone_pressed():
	#if !completeZone:
	#	get_node("../Camera2D").zoom_in(position - get_node("../Camera2D").position)
	#	get_node("In_Zone").visible = true;


func ZoneComplete():
	get_node("CompleteState").visible = true


func _on_tree_entered():
	if NumOfMinigame < PlayerVariables.MinigameStage :
		ZoneComplete()
