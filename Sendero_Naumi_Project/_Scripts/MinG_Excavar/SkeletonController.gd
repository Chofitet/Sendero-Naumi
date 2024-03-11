extends Node2D

@onready var checkTrue = $CheckAllTrue
@onready var anim = $AnimationPlayer
var Book = preload("res://Scenes/Zona_Megafauna/evento_libro.tscn")
@export var ParentBook : Control
@export var Statemachine : Node
@export var topoController : CharacterBody2D
var isPassInstance

func _ready():
	for i in checkTrue.get_children():
		i.AllSpots.connect(DoDiscoverAnim.bind(i))
	checkTrue.AllTrue.connect(LastInstance)

func DoDiscoverAnim(x):
	var instance = Book.instantiate()
	ParentBook.add_child(instance)
	topoController.ConnectBook(instance)
	x.get_node("particles").Emit()
	x.z_index = 2
	var initScale = x.scale
	var tween = get_tree().create_tween()
	tween.tween_property(x,"scale",initScale*1.15,0.3).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(x,"scale",initScale,0.3).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	instance.SetSkeleton(x.name)
	instance.DoAnim(topoController)
	checkTrue.CheckTrue()
	if isPassInstance:
		instance.IsPassingInstance(Statemachine)

func LastInstance():
	isPassInstance = true
