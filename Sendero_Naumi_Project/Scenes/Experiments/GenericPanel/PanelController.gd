@tool
extends Panel

@export var RefreshData : bool:
	set(new_value):
		refreshData(0)

@export var AppearInBeginning : bool
@export var TimeToAppear : float
@onready var label = $label
@onready var _BotonDerecho = $BtnDerAnchor/btnDer
@onready var _BotonIzquierda = $btnIzqAnchor/btnIzq
@onready var _BotonCentral = $btnCentralAnchor/btnCentral
@onready var SkipButton = $ButtonSkipWritting
var _btns =[]
@export var characters_per_second : float = 45
var BotonDerecho
var BotonIzquierdo
var BotonCentral
var anim : AnimationPlayer 
@export var Texts : Array[TextField] 

@export var Instanciate : bool:
	set(new_value):
		InstanciateIntermediate()

@export var IntermediateEmmiterData : IntermediateData

var pop = preload("res://Scenes/UI_Scenes/pop.tscn")

signal RigthBTNPress
signal LeftBTNPress
signal CenterBTNPress

func refreshData(numPanel : int):
	
	DetectBoldText(numOfPanel)
	
	var inInEditor = Engine.is_editor_hint()
	
	_BotonDerecho.visible = false
	_BotonCentral.visible = false
	_BotonIzquierda.visible = false
	BotonDerecho = false
	BotonCentral = false
	BotonIzquierdo = false
	
	label.text = Texts[numPanel].Text
	
	for btn in Texts[numPanel].buttons:
		var _texture = btn.texture
		if btn.Place ==  ButtonPanel.place.rigth:
			_BotonDerecho.visible = inInEditor
			$BtnDerAnchor/btnDer/Icon.texture = _texture
			BotonDerecho = true
		
		if btn.Place ==  ButtonPanel.place.center:
			_BotonCentral.visible = inInEditor
			$btnCentralAnchor/btnCentral/Icon.texture = _texture
			BotonCentral = true
		
		if btn.Place ==  ButtonPanel.place.left:
			_BotonIzquierda.visible = inInEditor
			$btnIzqAnchor/btnIzq/Icon.texture = _texture
			BotonIzquierdo = true
	
	if Engine.is_editor_hint(): label.visible_ratio = true

func InstanciateIntermediate():
	
	var instance = load("res://Scenes/Experiments/GenericPanel/IntermediateSignal.tscn").instantiate()
	add_child(instance)
	instance.AssingIntermediateData(IntermediateEmmiterData)
	instance.owner = get_tree().edited_scene_root
	
	instance.name = "Panel(" + str(IntermediateEmmiterData.NumberOfPanel) + ") Btn(" + IntermediateData.place.keys()[IntermediateEmmiterData.Place] + ")"
	
	IntermediateEmmiterData = null
	

var numOfPanel : int = 0

func _ready():
	_btns.append(_BotonDerecho)
	_btns.append(_BotonIzquierda)
	_btns.append(_BotonCentral)
	anim = $AnimationPlayer
	_BotonDerecho.visible = false
	_BotonIzquierda.visible = false
	_BotonCentral.visible = false
	pivot_offset =  Vector2(size.x/2,size.y/2)
	if !Engine.is_editor_hint(): label.visible_ratio = 0
	refreshData(0)
	if AppearInBeginning: 
		EnterPanel()
		if !Engine.is_editor_hint(): visible= false
	else : if !Engine.is_editor_hint(): visible= false
	SkipButton.pressed.connect(SkipWritting)
	
	for child in get_children():
		if child.has_method("ConnectSignal"):
			child.ConnectSignal()

func EnterPanel():
	await  get_tree().create_timer(TimeToAppear).timeout
	anim.play("enter_panel")
	await anim.animation_finished
	typingAnim()

var tweenWritting : Tween
func typingAnim():
	var text_length = label.text.length()
	var duration = text_length / characters_per_second
	label.visible_ratio = 0
	SkipButton.visible = true
	tweenWritting = get_tree().create_tween()
	tweenWritting.tween_property(label,"visible_ratio",1,duration)
	
	await tweenWritting.finished
	AppearButtonAnim()
	SkipButton.visible = false
	

func AppearButtonAnim():
	if BotonDerecho: PlayAnimation(_BotonDerecho)
	if BotonIzquierdo: PlayAnimation(_BotonIzquierda)
	if BotonCentral: PlayAnimation(_BotonCentral)

func PlayAnimation(btn):
	var path : String = btn.get_path()
	path = path + "/AnimationPlayer"
	var animator = get_node(path)
	animator.play("appear")
	await animator.animation_finished
	animator.play("idle")


func ButtonPress(btn):
	
	InstanciateButtonPOP(_btns[btn])
	
	_BotonDerecho.visible = false
	_BotonCentral.visible = false
	_BotonIzquierda.visible = false
	if numOfPanel == Texts.size() - 1: ExitPanel()
	else:ChangeToNextText()


func ExitPanel():
	$AnimationPlayer.play("exit_panel")

func ChangeToNextText():
	numOfPanel += 1
	var anim = $AnimationPlayer
	anim.play("change_panel")
	await anim.animation_finished
	label.visible = true
	refreshData(numOfPanel)
	typingAnim()

func rigthBTNConnect():
	await get_tree().create_timer(0.2).timeout
	RigthBTNPress.emit(numOfPanel)

func leftBTNConnect():
	await get_tree().create_timer(0.2).timeout
	LeftBTNPress.emit(numOfPanel)

func centerBTNConnect():
	await get_tree().create_timer(0.2).timeout
	CenterBTNPress.emit(numOfPanel)

func InstanciateButtonPOP(btn):
	var POPInstance = pop.instantiate()
	get_parent().add_child(POPInstance)
	POPInstance.global_position = btn.global_position + Vector2(45,45)

func DetectBoldText(numPanel):
	
	if  Texts[numPanel].Text.contains("[b]"):
		label = $labelRich
	else: label = $label
		

func SkipWritting():
	tweenWritting.kill()
	label.visible_ratio = 1
	AppearButtonAnim()
	SkipButton.visible = false
