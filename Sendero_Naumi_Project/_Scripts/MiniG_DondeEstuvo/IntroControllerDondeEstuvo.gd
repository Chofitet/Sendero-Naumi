extends Control

@onready var anim = $AnimationPlayer
@onready var panel1 = $Panel
@onready var panel2 = $Panel2
@onready var btn1 = $Panel/Button2
@onready var btn2 = $Panel2/Button2
@onready var canvas = $CanvasLayer
var instanceTransition = preload("res://Scenes/Experiments/IndividualFade.tscn")
var trextureFade = preload("res://addons/scene_manager/shader_patterns/diagonal.png")
@export var StateMachine : Node

func _ready():
	btn1.pressed.connect(PassFirstPanel)
	btn2.pressed.connect(PassSecondPanel)

func PassFirstPanel():
	panel1.visible = false
	anim.play("open_Door")
	await anim.animation_finished
	panel2.visible = true

func PassSecondPanel():
	panel2.visible = false
	var instance = instanceTransition.instantiate()
	canvas.add_child(instance)
	instance.init(trextureFade,2,true)
	await get_tree().create_timer(2).timeout
	PassStateMinigame()
	var instance2 = instanceTransition.instantiate()
	canvas.add_child(instance2)
	instance2.init(trextureFade,2,false,false)

func PassStateMinigame():
	StateMachine.Trigger_On_Child_Transition("Juego")
