@tool
extends Panel
signal BtnAppear

@export var RefreshData : bool:
	set(new_value):
		refreshData(1)

@export var AppearInBeginning : bool
@export var ExistingInBeginning : bool
@export var TimeToAppear : float
@export var SetEnterOnce: bool
@export var RepitingPanel : bool
@export var AppearSound  : String = "basic"
var isAlternetiveTheme
var EnterOnce
@onready var label = $label
@onready var _BotonDerecho = $BtnDerAnchor/btnDer
@onready var _BotonIzquierda = $btnIzqAnchor/btnIzq
@onready var _BotonCentral = $btnCentralAnchor/btnCentral
#@onready var SkipButton = $ButtonSkipWritting
@export var NoSkipWiting : bool = false
var btnDontPassPanel
var content =[]
var isSkiping = false
var isOn = false
var _btns =[]
var Characters_per_second : float = 78
var BotonDerecho
var BotonIzquierdo
var BotonCentral
var anim : AnimationPlayer 
@export var instanceAndButtonExit : Vector2

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
	
	print("refresh data")
	btnDontPassPanel = false
	
	DetectBoldText(numOfPanel)
	
	var inInEditor = Engine.is_editor_hint()
	
	_BotonDerecho.visible = false
	_BotonCentral.visible = false
	_BotonIzquierda.visible = false
	ResetButtonAnimation(_BotonDerecho)
	ResetButtonAnimation(_BotonIzquierda)
	ResetButtonAnimation(_BotonCentral)
	BotonDerecho = false
	BotonCentral = false
	BotonIzquierdo = false
	var textData
	
	if RepitingPanel: 
		textData = Texts[0]
	else:
		textData = Texts[numPanel -1]
	
	if textData.writingSpeed != 0:
		Characters_per_second = textData.writingSpeed
	else : Characters_per_second = 72
	
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
		var cont = content[textData.NumOfContent - 1]
		var tween = get_tree().create_tween()
		tween.tween_property(cont,"modulate",Color.WHITE,0.5)
		cont.visible = true
		for contchild in cont.get_children():
			if contchild is AnimationPlayer: contchild.play("content")
	
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
	
	#SkipButton.pressed.connect(SkipWritting)
	
	for child in get_children():
		if child.has_method("ConnectSignal"):
			child.ConnectSignal()
	
	if ExistingInBeginning:
		anim.play("beggining")
		AppearButtonAnim()

func EnterPanel():
	print("enter panel: " + name)
	ResetButtonAnimation(_BotonDerecho)
	ResetButtonAnimation(_BotonIzquierda)
	ResetButtonAnimation(_BotonCentral)
	isOn = true
	if SetEnterOnce:
		if EnterOnce: return
		EnterOnce = true
	await  get_tree().create_timer(TimeToAppear).timeout
	anim.play("enter_panel")
	SoundManager.play("appear",AppearSound)
	await anim.animation_finished
	typingAnim()

var tweenWritting : Tween
func typingAnim():
	SoundManager.play("typing",AppearSound)
	var text_length = get_visible_text_length(label.text)
	var duration = text_length / Characters_per_second
	label.visible_ratio = 0
	if !NoSkipWiting: isSkiping = true
	tweenWritting = get_tree().create_tween()
	tweenWritting.tween_property(label,"visible_ratio",1,duration)
	
	await tweenWritting.finished
	AppearButtonAnim()
	isSkiping = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("TouchScreen"):
		if isSkiping: SkipWritting()

func get_visible_text_length(text: String) -> int:
	var regex = RegEx.new()
	regex.compile("\\[/?\\w+(=[^\\]]+)?\\]")
	return regex.sub(text, "", true).length()

func AppearButtonAnim():
	if BotonDerecho: PlayAnimation(_BotonDerecho)
	if BotonIzquierdo: PlayAnimation(_BotonIzquierda)
	if BotonCentral: PlayAnimation(_BotonCentral)
	BtnAppear.emit()

func PlayAnimation(btn):
	var path : String = btn.get_path()
	path = path + "/AnimationPlayer"
	var animator = get_node(path)
	animator.play("appear")
	await animator.animation_finished
	animator.play("idle")

func ResetButtonAnimation(btn):
	var path : String = btn.get_path()
	path = path + "/AnimationPlayer"
	var animator = get_node(path)
	animator.play("RESET")

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
	elif instanceAndButtonExit == Vector2(numOfPanel,btn): 
		numOfPanel += 1
		ExitPanel()
	else:ChangeToNextText()
	


func ExitPanel():
	$AnimationPlayer.play("exit_panel")
	isOn = false

func ChangeToNextText():
	numOfPanel += 1
	for c in content:
		c.visible = false
	var anim = $AnimationPlayer
	anim.play("change_panel")
	await anim.animation_finished
	label.visible = true
	SoundManager.play("appear",AppearSound)
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
	else: 
		label = $label
		

func SkipWritting():
	tweenWritting.kill()
	label.visible_ratio = 1
	AppearButtonAnim()
	isSkiping = false

var toExitPanel
func HoldExitPanel():
	toExitPanel = true
