extends Node2D

@onready var glass = $manzana/GlassMask/GlassMask2
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
	glass.material.set_shader_parameter("cutoff",decrement)
	if glass.material.get_shader_parameter("cutoff") <= 0:
		$manzana/MoveParentTo.MoveParent()
		$manzana/ScaleParent.ScaleParent()
		$Ingredient/MoveParentTo.MoveParent()
		$Ingredient/ScaleParent.ScaleParent()
