@tool
extends Panel

@export var RefreshData : bool:
	set(new_value):
		refreshData(0)

@onready var label = $label
@onready var _BotonDerecho = $BtnDerAnchor/btnDer
@onready var _BotonIzquierda = $btnIzqAnchor/btnIzq
@onready var _BotonCentral = $btnCentralAnchor/btnCentral
@export var characters_per_second : float = 45
var BotonDerecho
var BotonIzquierdo
var BotonCentral

@export var Texts : Array[TextField] 

func refreshData(numPanel : int):
	
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
			$btnCentralAnchor/btnCentral.visible = _texture
			BotonCentral = true
		
		if btn.Place ==  ButtonPanel.place.left:
			_BotonIzquierda.visible = inInEditor
			$btnIzqAnchor/btnIzq/Icon.texture = _texture
			BotonIzquierdo = true
	

var numOfPanel : int = 0

func _ready():
	_BotonDerecho.visible = false
	_BotonIzquierda.visible = false
	_BotonCentral.visible = false
	pivot_offset =  Vector2(size.x/2,size.y/2)
	label.visible_ratio = 0
	refreshData(0)
	EnterPanel()

func EnterPanel():
	var anim : AnimationPlayer = $AnimationPlayer
	anim.play("enter_panel")
	await anim.animation_finished
	typingAnim()

func typingAnim():
	var text_length = label.text.length()
	var duration = text_length / characters_per_second
	
	var tween = get_tree().create_tween()
	tween.tween_property(label,"visible_ratio",1,duration)
	
	await tween.finished
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
	
	if numOfPanel == Texts.size() - 1:
		ExitPanel()

func ExitPanel():
	$AnimationPlayer.play("exit_panel")

func ChangeToNextText():
	numOfPanel += 1
	var anim = $AnimationPlayer
	anim.play("change_panel")
	await anim.animation_finished
	refreshData(numOfPanel)
