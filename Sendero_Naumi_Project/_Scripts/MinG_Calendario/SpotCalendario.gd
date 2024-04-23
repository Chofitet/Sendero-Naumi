extends Control
@onready var CalendarioEn = $Enero/Calendario_Enero
@onready var anim = $AnimationPlayer
@onready var panel = $Panel
@export var Instances :=[]
@export var radius_facus : float
@export var textures_Answers2 : Array[Texture] = []
var isfocusing : bool
var index


func _ready():
	get_parent().get_parent().Transitioned.connect(UpdateWithInstance)
	
func _process(delta):
	if isfocusing:
		index -= delta 
		CalendarioEn.material.set_shader_parameter("focus_radius", index);
		if index <= radius_facus:
			isfocusing = false
			panel.visible = true

func UpdateWithInstance():
	var LabelAnswers
	if get_node(Instances[0]).visible:
		anim.play("enero_enter")
		await anim.animation_finished
		anim.play("Answer_Enter")
	elif get_node(Instances[1]).visible:
		CalendarioEn.visible = false
		LabelAnswers = ["BIG BANG","FORMACIÓN DE LA GALAXIA","PRIMEROS MAMÍFEROS","PRIMEROS INCECTOS"]
		$AnswerController.Set_Slot("ABRIL",panel.get_node("Label"),textures_Answers2,0,LabelAnswers)
		anim.play("Answer_Enter")
	elif get_node(Instances[2]).visible:
		CalendarioEn.visible = false
		LabelAnswers = ["FORMACIÓN DE LA GALAXIA","BIG BANG","PRIMEROS INCECTOS","NACIÓ MESSI"]
		$AnswerController.Set_Slot("JUNIO",panel.get_node("Label"),textures_Answers2,3,LabelAnswers)
		anim.play("Answer_Enter")
	elif get_node(Instances[3]).visible:
		CalendarioEn.visible = false
		LabelAnswers = ["NACIÓ DIOS","BIG BANG","INVENCION DE LA ESCRITURA","NACIÓ MESSI"]
		$AnswerController.Set_Slot("DICIEMBRE 10",panel.get_node("Label"),textures_Answers2,2,LabelAnswers,true)
		anim.play("Answer_Enter")

func TofinScreen(stateMachine):
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position", Vector2(-1000,position.y), 2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	await tween.finished
	stateMachine.Trigger_On_Child_Transition("Fin")
