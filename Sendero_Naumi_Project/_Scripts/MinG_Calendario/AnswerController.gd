extends Node2D

@onready var spot = $Spot
@onready var answer = $AnswerSpot/answer
@onready var anim = $AnimationPlayer
@export var hBoxConteiner : Control
@export var StateMachine : Node

var isLastInstance
var AnswerTexture 

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
	if isLastInstance:
		get_parent().TofinScreen(StateMachine)
		return
	StateMachine.Trigger_On_Child_Transition("Juego")
	answer.texture = null
	AnswerTexture = null
	spot.Reset()

func WrongAnswer():
	anim.play("wrongAnim")
	await anim.animation_finished
	anim.play("RESET")
	hBoxConteiner.ReOrganizePlates()
	answer.texture = null
	AnswerTexture = null
	spot.Reset()

func Set_Slot(txt, panel, answers, correctAnswer,LabelTexture, _isLastInstance = false):
	var i = 0
	isLastInstance = _isLastInstance
	for date in hBoxConteiner.get_children():
		date.texture = answers[i]
		date.get_node("Label").text = LabelTexture[i]
		if i == correctAnswer:
			spot.RigthObject = date.get_child(1)
		i += 1
	hBoxConteiner.Reset()
	$DateQuestion.visible = true
	$DateQuestion/MASK/date/Label.text = txt
	anim.play_backwards("rigthAnim")
	panel.text = "¿QUÉ PASÓ EN " + txt + "?" 
	await anim.animation_finished
	anim.play("RESET")
