@tool
extends Button

@onready var anim = $AnimationPlayer


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
	anim.play("EnterButton")
	await anim.animation_finished
	if !noSway: anim.play("Idle")

func ExitAnim():
	anim.stop()
	InstanciateButtonPOP()
	visible = false

func InstanciateButtonPOP():
	var POPInstance = pop.instantiate()
	get_parent().add_child(POPInstance)
	POPInstance.global_position = global_position + Vector2(45,45) * scale
	SoundManager.play("UI","touch")
	await  get_tree().create_timer(2).timeout
	
