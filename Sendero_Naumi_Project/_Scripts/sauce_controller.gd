extends Node2D

@onready var glass = $GlassMask/GlassMask2
@export var speed : float
@export var GlassSpeed : float
var incruse : float = 0
var inPressed = false
var sauce_instance = load("res://shaders/prueba_shader.tscn")

func ActiveLevel():
	visible = true

func _ready():
	$Button.button_down.connect(ButtonPress)

func ButtonPress():
	var sauce = sauce_instance.instantiate()
	add_child(sauce)
	sauce.init($Button,speed)
	sauce.toBathe.connect(FillGlass)

var decrement = 1
func FillGlass():
	#glass.position.y += get_process_delta_time() * GlassSpeed
	decrement -=  get_process_delta_time() * GlassSpeed * 0.001
	print(decrement)
	glass.material.set_shader_parameter("cutoff",decrement)
