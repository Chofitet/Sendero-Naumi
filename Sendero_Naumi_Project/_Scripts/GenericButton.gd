@tool
extends Button

@onready var anim = $AnimationPlayer

signal pressedDelay

@export var enterInBeggining : bool

@export var noSway : bool

@export var noSquiggling : bool

var pop = preload("res://Scenes/UI_Scenes/pop.tscn")


@export var Icon : Texture:
	set(value):
		Icon = value
		if !Engine.is_editor_hint() : return
		$TextureRect.texture = Icon

func _ready():
	if enterInBeggining: EnterAnim()
	pressed.connect(ExitAnim)
	$TextureRect.texture = Icon
	if noSquiggling: $SquigglingSprite.queue_free()

func EnterAnim():
	if visible == true: return
	anim.play("EnterButton")
	await anim.animation_finished
	if !noSway: anim.play("Idle")

func ExitAnim(noPOP : bool = false):
	anim.stop()
	if !noPOP: InstanciateButtonPOP()
	visible = false
	await  get_tree().create_timer(0.3).timeout
	pressedDelay.emit()

func InstanciateButtonPOP():
	var POPInstance = pop.instantiate()
	get_parent().add_child(POPInstance)
	POPInstance.global_position = $centerPosition.global_position
	SoundManager.play("UI","touch")
	await  get_tree().create_timer(2).timeout
	
