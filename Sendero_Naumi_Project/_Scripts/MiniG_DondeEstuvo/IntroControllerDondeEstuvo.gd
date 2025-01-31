extends Control

@onready var anim = $AnimationPlayer
@onready var canvas = $CanvasLayer
var instanceTransition = preload("res://Scenes/Experiments/IndividualFade.tscn")
var trextureFade = preload("res://addons/scene_manager/shader_patterns/diagonal.png")
@export var StateMachine : Node

func PassSecondPanel():
	var instance = instanceTransition.instantiate()
	canvas.add_child(instance)
	instance.init(trextureFade,1,true)
	await get_tree().create_timer(1).timeout
	PassStateMinigame()
	var instance2 = instanceTransition.instantiate()
	canvas.add_child(instance2)
	instance2.init(trextureFade,1,false,false)

func PassStateMinigame():
	StateMachine.Trigger_On_Child_Transition("Juego")

