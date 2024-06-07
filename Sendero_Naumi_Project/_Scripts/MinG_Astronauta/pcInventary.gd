extends Control
@onready var computer = $Computer
var MeteorosUI :=[]
var _misionComplete
@onready var fade = preload("res://Scenes/Experiments/IndividualFade.tscn")
@onready var fadeTexture = preload("res://addons/scene_manager/shader_patterns/diagonal.png")
@export var StateMachine : Node
@export var phantomCam : PhantomCamera2D
signal InventaryGone

func _ready():
	$Panel/Button.pressed.connect(MakeFade)
	for m in $Panel/HBoxContainer.get_children():
		MeteorosUI.append(m.get_child(0).get_node("AnimationPlayer"))

func CheckMeteoro(index):
	visible = true
	$Panel/AnimationPlayer.play("enterPanel")
	var anim : AnimationPlayer = MeteorosUI[index] 
	await  $Panel/AnimationPlayer.animation_finished
	$Panel.clip_contents = false
	anim.play("check")
	await anim.animation_finished
	computer.Setface("smile")
	await get_tree().create_timer(2).timeout
	if _misionComplete:
		CompleteMision()
		return
	InventaryGone.emit()
	$Panel/AnimationPlayer.play("RESET")
	computer.Setface("idle")
	$Panel.clip_contents = true
	visible = false

func CompleteMision():
	$Panel/HBoxContainer.visible = false
	$Panel/MisionLabel.visible = true
	await get_tree().create_timer(2).timeout
	$Panel/Button.visible = true


func MakeFade():
	var instantiateFade = fade.instantiate()
	get_parent().add_child(instantiateFade)
	instantiateFade.init(fadeTexture,2,true)
	await get_tree().create_timer(2).timeout
	phantomCam.set_priority(0)
	StateMachine.Trigger_On_Child_Transition("Fin")
	visible = false
	var instantiateFade2 = fade.instantiate()
	get_parent().add_child(instantiateFade2)
	instantiateFade2.init(fadeTexture,2,false,false)
	
func MisionComplete():
	_misionComplete = true
	pass
	
