@tool
extends Node2D

@export var player : NodePath

@export var RotateInEnter : bool
var isRotating : bool

@export var isInactiveDialogue : bool

@export var txt: String:
	set(new_value):
		if !Engine.is_editor_hint(): return
		#txt = new_value
		#$Panel/Label.text = txt

@export var ScaleFactorDialogue: float:
	set(new_value):
		if !Engine.is_editor_hint(): return
		ScaleFactorDialogue = new_value
		$Panel.scale = Vector2(ScaleFactorDialogue,ScaleFactorDialogue)

@export var inversedDialogue : bool:
	set(new_value):
		if !Engine.is_editor_hint(): return
		inversedDialogue = new_value
		var auxPos = $Panel/Label.position.x
		if inversedDialogue:
			$Panel.scale.x = ScaleFactorDialogue * -1
			$Panel/Label.scale.x = -1
			$Panel/Label.position.x += $Panel/Label.size.x
		else:
			$Panel.scale.x = ScaleFactorDialogue 
			$Panel/Label.scale.x = 1
			$Panel/Label.position.x = auxPos

@export var DialogueDistance : Vector2:
	set(new_value):
		if !Engine.is_editor_hint(): return
		DialogueDistance = new_value
		$Panel.position = DialogueDistance

@export var AstronautAngle: float:
	set(new_angle):
		if !Engine.is_editor_hint(): return
		AstronautAngle = new_angle
		$sprite.rotation = AstronautAngle

func _ready():
	if Engine.is_editor_hint(): return
	$Panel.visible = false
	$Area2D.area_entered.connect(ShowDialogue)
	$Area2D.area_exited.connect(StartHideDialogue)

func ShowDialogue(x):
	if isInactiveDialogue: return
	if x.is_in_group("Player"):
		if $Panel.visible == false : SoundManager.play("guy","dialogo")
		$Panel.visible = true
		if timerDialogue != null: timerDialogue.timeout.disconnect(HideDialogue)
		if RotateInEnter:
			isRotating = true

var timerDialogue = null

func StartHideDialogue(x):
	if x.is_in_group("Player"):
		timerDialogue = get_tree().create_timer(2)
		timerDialogue.timeout.connect(HideDialogue)

func HideDialogue():
	$Panel.visible = false
	timerDialogue = null

var incruse = 0
@export var increment : float
func _process(delta):
	if !RotateInEnter: return
	
	$sprite.rotation_degrees = $sprite.rotation_degrees + incruse
	
	if !isRotating :
		if incruse <= 0: return
		incruse -= delta * increment
		
	
	if incruse >= 2.5: return
	
	if isRotating:
		incruse += delta * increment

func SetVisibility(shape,x):
	visible = x

func disabledCollisionShape():
	$Area2D/CollisionShape2D.disabled = true
	
 
func InactiveDialogue():
	isInactiveDialogue = true

func ActiveDialogue():
	isInactiveDialogue = false
