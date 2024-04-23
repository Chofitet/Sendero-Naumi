@tool
extends Node2D

@export var player : NodePath

@export var txt: String:
	set(new_value):
		if !Engine.is_editor_hint(): return
		txt = new_value
		$Panel/Label.text = txt

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
	$Area2D.area_exited.connect(HideDialogue)

func ShowDialogue(x):
	if x.is_in_group("Player"):
		$Panel.visible = true

func HideDialogue(x):
	if x.is_in_group("Player"):
		$Panel.visible = false
