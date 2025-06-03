extends Node2D

@onready var checkTrue = $CheckAllTrue
@onready var anim = $AnimationPlayer
var Book = preload("res://Scenes/Zona_Megafauna/evento_libro.tscn")
var smilodonte = preload("res://Scenes/Zona_Megafauna/Smilodonte_Draw.tscn")
@export var ParentBook : Control
@export var Statemachine : Node
@export var topoController : CharacterBody2D
@export var VibrationIntencity : float
signal ConnectInventaryBTN
signal AppearIcon
var isPassInstance
var InstanceOnce

func _ready():
	for i in checkTrue.get_children():
		i.AllSpots.connect(DoDiscoverAnim.bind(i))
	checkTrue.AllTrue.connect(LastInstance)

func DoDiscoverAnim(x):
	var instance = Book.instantiate()
	ParentBook.add_child(instance)
	topoController.ConnectBook(instance)
	instance.DrawFinish.connect(EmitAppearIconSignal)
	x.get_node("particles").Emit()
	SoundManager.play("fosil","explota")
	x.self_modulate = Color.WHITE
	x.z_index = 1
	if x.get_node("vibration") != null:
		x.get_node("vibration").doVibrate(VibrationIntencity)
	var initScale = x.scale
	var tween = get_tree().create_tween()
	tween.tween_property(x,"scale",initScale*1.15,0.3).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(x,"scale",initScale,0.3).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	ConnectInventaryBTN.emit(x)
	instance.SetSkeleton(x.name)
	instance.DoAnim(topoController)
	checkTrue.CheckTrue()
	if isPassInstance:
		instance.IsPassingInstance(Statemachine)
	await get_tree().create_timer(1).timeout
	PreInstanceShader()
	InstanceOnce = true
	

func EmitAppearIconSignal():
	AppearIcon.emit()

func LastInstance():
	isPassInstance = true

func PreInstanceShader():
	if InstanceOnce : return
	var instance = smilodonte.instantiate()
	add_child(instance)
