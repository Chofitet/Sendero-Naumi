extends Node2D

@onready var spot = $Spot
@onready var answer = $AnswerSpot/answer
@onready var anim = $AnimationPlayer
@export var hBoxConteiner : Control
@export var StateMachine : Node
@export var panel : Panel
@export var calendar : Sprite2D
signal RigthAnswere
var isLastInstance
var AnswerTexture 

func _process(delta):
	pass

func _ready():
	spot.OnSpot.connect(get_Answer)
	spot.RightAns.connect(RigthAnswer)
	spot.WrongAns.connect(WrongAnswer)

func get_Answer(x):
	AnswerTexture = x.texture
	answer.texture = AnswerTexture

func RigthAnswer():
	var tween = get_tree().create_tween()
	tween.tween_property(hBoxConteiner,"position",Vector2(hBoxConteiner.position.x,722),0.5)
	anim.play("rigthAnim")
	await anim.animation_finished
	anim.play("idle")
#	if isLastInstance:
#		get_parent().TofinScreen(StateMachine)
#		return
	RigthAnswere.emit()
	await get_tree().create_timer(1).timeout
	panel.ExitPanel()
	
	visible = false
	StateMachine.Trigger_On_Child_Transition("Juego")
	calendar.SetSlot()
	answer.texture = null
	AnswerTexture = null
	anim.play("RESET")
	spot.Reset()

func WrongAnswer():
	anim.play("wrongAnim")
	await anim.animation_finished
	anim.play("RESET")
	hBoxConteiner.ReOrganizePlates()
	answer.texture = null
	AnswerTexture = null
	spot.Reset()

func Set_Slot(txt, AnsweresTextures, correctAnswer, _isLastInstance = false):
	var i = 0
	visible = true
	isLastInstance = _isLastInstance
	for date in hBoxConteiner.get_children():
		date.texture = AnsweresTextures[i]
		if i == correctAnswer:
			spot.RigthObject = date.get_child(0)
		i += 1
	hBoxConteiner.Reset()
	panel.get_node("label").text = txt
	panel.EnterPanel()
	await anim.animation_finished
	anim.play("RESET")
