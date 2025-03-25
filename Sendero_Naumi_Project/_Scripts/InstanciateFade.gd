extends Control
var fadeInstance = preload("res://Scenes/Experiments/IndividualFade.tscn")
var texture = load("res://addons/scene_manager/shader_patterns/diagonal.png")
@export var stateMachine : Node 
@export var stateToChange : String
signal changeState

func InstanciateFade():
	var instance = fadeInstance.instantiate()
	get_parent().get_parent().add_child(instance)
	instance.init(texture,2,true)
	await get_tree().create_timer(2).timeout
	changeState.emit()
	stateMachine.Trigger_On_Child_Transition(stateToChange)
	var instance2 = fadeInstance.instantiate()
	get_parent().get_parent().add_child(instance2)
	instance2.init(texture,2,false,false)
