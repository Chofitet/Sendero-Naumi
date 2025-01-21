@tool
extends Panel
@onready var label = $label
@onready var _BotonDerecho = $btnDer
@onready var _BotonIzquierda = $btnDer
@export var TypingSpeed = 2

@export_multiline var _text : String: 
	set(new_value):
		if !Engine.is_editor_hint(): return
		_text = new_value
		label.text = _text


@export var TimeToAppearBTN = 0
@export var BotonDerecho : bool: 
	set(new_value):
		if !Engine.is_editor_hint(): return
		BotonDerecho = new_value
		$BtnDerAnchor/btnDer.visible = BotonDerecho
@export var BotonDerechoIcon : Texture:
	set(new_value):
		BotonDerechoIcon = new_value
		$BtnDerAnchor/btnDer/TextureRect.texture = BotonDerechoIcon

@export var BotonIzquierdo : bool: 
	set(new_value):
		if !Engine.is_editor_hint(): return
		BotonIzquierdo = new_value
		$btnIzqAnchor/btnIzq.visible = BotonIzquierdo
@export var BotonIzquierdoIcon : Texture:
	set(new_value):
		if !Engine.is_editor_hint(): return
		BotonIzquierdoIcon = new_value
		$btnIzqAnchor/btnIzq/TextureRect.texture = BotonIzquierdoIcon

@export var BotonCentral : bool: 
	set(new_value):
		if !Engine.is_editor_hint(): return
		BotonCentral = new_value
		$btnCentralAnchor/btnCentral.visible = BotonCentral
@export var BotonCentralIcon : Texture:
	set(new_value):
		BotonCentralIcon = new_value
		$btnCentralAnchor/btnCentral/TextureRect.texture = BotonCentralIcon



func _ready():
	pivot_offset =  Vector2(size.x/2,size.y/2)
	label.visible_ratio = 0
	EnterPanel()

func EnterPanel():
	var anim : AnimationPlayer = $AnimationPlayer
	anim.play("enter_panel")
	await anim.animation_finished
	typingAnim()

func typingAnim():
	var tween = get_tree().create_tween()
	tween.tween_property(label,"visible_ratio",1,TypingSpeed)
	
	if TimeToAppearBTN == 0:
		await tween.finished
		
	

func ActiveButton():
	pass
