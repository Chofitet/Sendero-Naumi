extends Control
@onready var computer = $Computer
var MeteorosUI :=[]
var _misionComplete
@onready var fade = preload("res://Scenes/Experiments/IndividualFade.tscn")
@onready var fadeTexture = preload("res://addons/scene_manager/shader_patterns/diagonal.png")
@export var StateMachine : Node
@export var phantomCam : PhantomCamera2D
@onready var PanelInventory = $PanelInventory
signal InventaryGone

func _ready():
	for m in $PanelInventory/HBoxContainer.get_children():
		MeteorosUI.append(m.get_child(0).get_node("AnimationPlayer"))

func CheckMeteoro(index):
	visible = true
	PanelInventory.EnterPanel()
	var anim : AnimationPlayer = MeteorosUI[index] 
	await  get_tree().create_timer(0.4).timeout
	anim.play("check")
	await anim.animation_finished
	computer.SmileAnim()
	await get_tree().create_timer(2).timeout
	if _misionComplete:
		CompleteMision()
		return
	InventaryGone.emit()
	PanelInventory.ExitPanel()
	await get_tree().create_timer(0.4).timeout
	computer.Setface("idle")
	visible = false

func CompleteMision():
	$PanelInventory/HBoxContainer.visible = false
	PanelInventory.ChangeToNextText()
	computer.Setface("talk")


## llamarlo con boton 
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
	
