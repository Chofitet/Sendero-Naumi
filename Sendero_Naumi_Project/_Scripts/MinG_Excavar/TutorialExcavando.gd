extends Control

@onready var area2d = $Area2D
@export var FirstInstance : Control
var Book = preload("res://Scenes/Zona_Megafauna/evento_libro.tscn")
@export var ParentBook : Control

func _ready():
	area2d.area_entered.connect(HideTutorial)
	visible = false

func ShowTutorial():
	if FirstInstance.visible:
		visible = true

func HideTutorial(x):
	if x.is_in_group("topo"):
		visible = false
	

func PreDoBookAnim():
	var instance = Book.instantiate()
	ParentBook.add_child(instance)
	instance.visible = false
	instance.DoAnim()
	await get_tree().create_timer(3).timeout
	instance.queue_free()
