extends Node2D
var line 
@onready var paintPoint = $PaintPoint
@onready var btn = $DragObject/Button
@export var appleSprite : Node2D
var lineInstantiate = load("res://Scenes/Zona_Astronomia/linea_manzana.tscn")
var isPainting

func _ready():
	btn.button_down.connect(SetIsPainting.bind(true))
	btn.button_up.connect(SetIsPainting.bind(false))

func SetIsPainting(x):
	await get_tree().create_timer(0.2).timeout
	line = lineInstantiate.instantiate()
	appleSprite.add_child(line)
	line.global_position = Vector2.ZERO
	line.add_point(paintPoint.global_position)
	isPainting = x

func _process(delta):
	if !isPainting : return
	line.add_point(paintPoint.global_position)
	

func AllTrue():
	print("paint")
