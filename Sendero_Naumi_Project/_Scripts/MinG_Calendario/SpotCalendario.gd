extends Control
@onready var anim = $AnimationPlayer
@export var radius_facus : float
@export var textures_Answers1 : Array[Texture] = []
@export var textures_Answers2 : Array[Texture] = []
@export var textures_Answers3 : Array[Texture] = []
@export var textures_Answers4 : Array[Texture] = []
@export var textures_Answers5 : Array[Texture] = []
@export var textures_Answers6 : Array[Texture] = []
@onready var InstanceManager = get_parent()
var isfocusing : bool
var index

func _ready():
	get_parent().get_node("CalendarZoom").ZoomFinished.connect(UpdateWithInstance)

func UpdateWithInstance():
	var LabelAnswers
	if InstanceManager.get_instance(0).visible:
		$AnswerController.Set_Slot("[center]
¿QUÉ PASÓ EN [b]ENERO[/b]?",textures_Answers1,0)
		anim.play("Answer_Enter")
	elif InstanceManager.get_instance(1).visible:
		$AnswerController.Set_Slot("[center]
¿QUÉ PASÓ EN [b]AGOSTO[/b]?",textures_Answers2,2)
		anim.play("Answer_Enter")
	elif InstanceManager.get_instance(2).visible:
		$AnswerController.Set_Slot("[center]
¿QUÉ PASÓ EL [b]21 DE DICIEMBRE[/b]?",textures_Answers3,2)
		anim.play("Answer_Enter")
	elif InstanceManager.get_instance(3).visible:
		$AnswerController.Set_Slot("[center]
¿QUÉ PASÓ EL [b]25 DE DICIEMBRE[/b]?",textures_Answers4,0)
		anim.play("Answer_Enter")
	elif InstanceManager.get_instance(4).visible:
		$AnswerController.Set_Slot("[center]
¿EN QUE [b]FECHA DE DICIEMBRE[/b]
SE EXTINGUIERON LOS DINOSAURIOS?",textures_Answers5,2)
		anim.play("Answer_Enter")
	elif InstanceManager.get_instance(5).visible:
		$AnswerController.Set_Slot("[center]
¿A QUÉ [b]HORA[/b] APARECIÓ EL HOMOSAPIENS?",textures_Answers6,2,true)
		anim.play("Answer_Enter")

func TofinScreen(stateMachine):
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position", Vector2(-1000,position.y), 2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	await tween.finished
	stateMachine.Trigger_On_Child_Transition("Fin")

