extends Node2D
@export var Pos : Marker2D
@export var StateMachine : Node

func _ready():
	$Button.Down.connect(AnimatedToPos)

func AnimatedToPos():
	$Button.visible = false
	var tween = get_tree().create_tween()
	tween.tween_property(self,"global_position", Pos.global_position, 1).set_ease(Tween.EASE_OUT_IN)
	await tween.finished
	instanciateFade()

func instanciateFade():
	var fadeInstance = load("res://Scenes/Experiments/IndividualFade.tscn")
	var texture = load("res://addons/scene_manager/shader_patterns/diagonal.png")
	var instance = fadeInstance.instantiate()
	get_parent().get_parent().add_child(instance)
	instance.init(texture,2,true)
	await get_tree().create_timer(2).timeout
	StateMachine.Trigger_On_Child_Transition("Fin")
	var instance2 = fadeInstance.instantiate()
	get_parent().get_parent().add_child(instance2)
	instance2.init(texture,2,false,false)

func PlayCordonAppear():
	$AnimationPlayer.play("cordon_anim")
