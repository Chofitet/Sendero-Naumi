extends Node2D

@onready var glass = $GlassMask/Glass
@export var speed : float
@export var GlassSpeed : float
var incruse : float = 0
var inPressed = false
var sauce_instance = load("res://Scenes/Zona_Astronomia/sauce.tscn")


func _ready():
	$Button.button_down.connect(ButtonPress)

func ButtonPress():
	var sauce = sauce_instance.instantiate()
	add_child(sauce)
	sauce.init($Button,speed)
	sauce.toBathe.connect(FillGlass)

func FillGlass():
	glass.position.y += get_process_delta_time() * GlassSpeed
	
