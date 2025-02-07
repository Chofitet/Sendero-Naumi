extends Control

@export var Objects : =[]
@onready var Spots = $MarginContainer/HBoxContainer.get_children()
@export var Finalpanel : Panel
@export var CenterClues : Control
@export var colorUI : Color
@export var StateMachine : Node
var i : int = 0
@onready var offset = get_parent().get_node("ScreenCenter")
@onready var overlay = get_parent().get_node("Overlay")
var PanelObj
signal AllPicked

func _ready():
	PanelObj = overlay.get_child(0)
	for O in Objects:
		var o = get_node(O)
		o.ToInventary.connect(SetInventarySpot.bind(o))
		o.ToCenter.connect(SetOverlayTrue.bind(o))
		o.NoCenter.connect(SetOverlayFalse.bind(o))

func SetInventarySpot(obj):
	Spots[i].modulate = colorUI
	var spotOffset = Vector2(Spots[i].size.x / 2 + 20, Spots[i].size.y /2 + 20)
	obj.ToPosition = Spots[i].get_node("center").global_position
	obj.z_index = 1
	i += 1
	if i == Objects.size():
		AllFinded()
		AllPicked.emit()

func AllFinded():
	get_parent().get_node("ScreenCenter/Clues").BlockOthersClues(self,false)
	for O in Objects:
			get_node(O).button.visible = false
	await get_tree().create_timer(1).timeout
	overlay.visible = true
	visible = false
	for O in Objects:
			get_node(O).visible = false
	var animPanel = CenterClues.get_node("AnimationPlayer")
	animPanel.play("appear")
	await  animPanel.animation_finished
	Finalpanel.EnterPanel()

func PassStateTransition():
	Finalpanel.ExitPanel()
	var animPanel = CenterClues.get_node("AnimationPlayer")
	animPanel.play("inPlace")
	await  animPanel.animation_finished
	StateMachine.Trigger_On_Child_Transition("Juego")

func instanciateFade():
	var fadeInstance = load("res://Scenes/Experiments/IndividualFade.tscn")
	var texture = load("res://addons/scene_manager/shader_patterns/diagonal.png")
	var instance = fadeInstance.instantiate()
	get_parent().get_parent().add_child(instance)
	instance.init(texture,2,true)
	await get_tree().create_timer(2).timeout
	StateMachine.Trigger_On_Child_Transition("Juego")
	var instance2 = fadeInstance.instantiate()
	get_parent().get_parent().add_child(instance2)
	instance2.init(texture,2,false,false)

func SetOverlayTrue(obj):
	overlay.visible = true
	for O in Objects:
		if get_node(O) != obj:
			get_node(O).button.visible = false

func SetOverlayFalse(obj):
	overlay.visible = false
	PanelObj.visible = false
	for O in Objects:
		get_node(O).button.visible = true
