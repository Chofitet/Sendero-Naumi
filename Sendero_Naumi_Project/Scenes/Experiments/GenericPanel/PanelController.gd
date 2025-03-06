@tool
extends Panel

@export var RefreshData : bool:
	set(new_value):
		refreshData(1)

@export var AppearInBeginning : bool
@export var ExistingInBeginning : bool
@export var TimeToAppear : float
@export var SetEnterOnce: bool
@export var RepitingPanel : bool
var isAlternetiveTheme
var EnterOnce
@onready var label = $label
@onready var _BotonDerecho = $BtnDerAnchor/btnDer
@onready var _BotonIzquierda = $btnIzqAnchor/btnIzq
@onready var _BotonCentral = $btnCentralAnchor/btnCentral
@onready var SkipButton = $ButtonSkipWritting
var btnDontPassPanel
var content =[]

var _btns =[]
var Characters_per_second : float = 78
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
	
	
	btnDontPassPanel = false
	
	DetectBoldText(numOfPanel)
	
	var inInEditor = Engine.is_editor_hint()
	
	_BotonDerecho.visible = false
	_BotonCentral.visible = false
	_BotonIzquierda.visible = false
	BotonDerecho = false
	BotonCentral = false
	BotonIzquierdo = false
	var textData
	
	if RepitingPanel: 
		textData = Texts[0]
	else:
		textData = Texts[numPanel -1]
	
	if textData.PanelTheme != null:
		set_theme(textData.PanelTheme)
	
	label.text = textData.Text
	if textData.SizePanel != Vector2.ZERO: 
		var tween = get_tree().create_tween()
		tween.tween_property(self,"size",textData.SizePanel,0.3)
		
	if textData.Position != Vector2.ZERO:
		var auxVector = textData.Position
		if textData.Position.x == 0:
			auxVector.x = position.x
		if textData.Position.y == 0:
			auxVector.y = position.y
		var tween = get_tree().create_tween()
		tween.tween_property(self,"position",auxVector,0.3)
	
	for btn in textData.buttons:
		var _texture = btn.texture
		var string = btn.label
		if btn.Place ==  ButtonPanel.place.rigth:
			_BotonDerecho.visible = inInEditor
			$BtnDerAnchor/btnDer/Icon.texture = _texture
			$BtnDerAnchor/btnDer/Icon/Label.text = string
			BotonDerecho = true
			
		if btn.Place ==  ButtonPanel.place.center:
			_BotonCentral.visible = inInEditor
			$btnCentralAnchor/btnCentral/Icon.texture = _texture
			$btnCentralAnchor/btnCentral/Icon/Label.text = string
			BotonCentral = true
		
		if btn.Place ==  ButtonPanel.place.left:
			_BotonIzquierda.visible = inInEditor
			$btnIzqAnchor/btnIzq/Icon.texture = _texture
			$btnIzqAnchor/btnIzq/Icon/Label.text = string
			BotonIzquierdo = true
			
		if btn.dontPassPanel: btnDontPassPanel = true
		
	
	for cont in get_children():
		if cont.name.contains("content"):
			content.append(cont)
			cont.visible = false
			cont.modulate.a = 0
	
	if textData.NumOfContent != 0:
		var tween = get_tree().create_tween()
		tween.tween_property(content[textData.NumOfContent - 1],"modulate",Color.WHITE,0.5)
		content[textData.NumOfContent - 1].visible = true
	
	if Engine.is_editor_hint(): label.visible_ratio = true

func InstanciateIntermediate():
	
	var instance = load("res://Scenes/Experiments/GenericPanel/IntermediateSignal.tscn").instantiate()
	add_child(instance)
	instance.AssingIntermediateData(IntermediateEmmiterData)
	instance.owner = get_tree().edited_scene_root
	
	instance.name = "Panel(" + str(IntermediateEmmiterData.NumberOfPanel) + ") Btn(" + IntermediateData.place.keys()[IntermediateEmmiterData.Place] + ")"
	
	IntermediateEmmiterData = null
	

var numOfPanel : int = 1

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
	refreshData(1)
	if AppearInBeginning: 
		EnterPanel()
		if !Engine.is_editor_hint(): visible= false
	else : if !Engine.is_editor_hint(): visible= false
	
	SkipButton.pressed.connect(SkipWritting)
	
	for child in get_children():
		if child.has_method("ConnectSignal"):
			child.ConnectSignal()
	
	if ExistingInBeginning:
		anim.play("enter_panel")
		anim.seek(0.4)
		await get_tree().create_timer(0.001).timeout
		label.visible_ratio = 1
		label.visible = true
		AppearButtonAnim()

func EnterPanel():
	if SetEnterOnce:
		if EnterOnce: return
		EnterOnce = true
	await  get_tree().create_timer(TimeToAppear).timeout
	anim.play("enter_panel")
	await anim.animation_finished
	typingAnim()

var tweenWritting : Tween
func typingAnim():
	var text_length = label.text.length()
	var duration = text_length / Characters_per_second
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

var once = false 
func ButtonPress(btn):
	SoundManager.play("UI","touch")
	InstanciateButtonPOP(_btns[btn])
	
	_BotonDerecho.visible = false
	_BotonCentral.visible = false
	_BotonIzquierda.visible = false
	if btnDontPassPanel : 
		numOfPanel += 1
		return
	if numOfPanel  == Texts.size() or RepitingPanel: 
		ExitPanel()
		if once : return
		if RepitingPanel: once = true
		numOfPanel += 1
	else:ChangeToNextText()
	


func ExitPanel():
	$AnimationPlayer.play("exit_panel")

func ChangeToNextText():
	numOfPanel += 1
	var anim = $AnimationPlayer
	anim.play("change_panel")
	await anim.animation_finished
	label.visible = true
	typingAnim()

func RefreshToActualPanel():
	refreshData(numOfPanel)


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
	if Texts.size() < numPanel -1: return
	if  Texts[numPanel -1].Text.contains("[b]"):
		label.text = ""
		label = $labelRich
	else: label = $label
		

func SkipWritting():
	tweenWritting.kill()
	label.visible_ratio = 1
	AppearButtonAnim()
	SkipButton.visible = false
