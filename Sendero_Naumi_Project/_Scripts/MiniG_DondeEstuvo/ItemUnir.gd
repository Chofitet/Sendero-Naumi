extends TextureRect

@onready var collShape = $Area2D/CollisionShape2D
@onready var button = $Button
@onready var area = $Area2D
@export var correctSpot : TextureRect
var isInArea
var line 
var posClick
var ClickInButton : bool = false
var isComplete : bool = false
var onHold : bool = false

func _ready():
	button.button_down.connect(OnButton)
	area.area_entered.connect(OnArea)
	area.area_exited.connect(OutArea)
	line = $Line2D


func _input(event):
	if Input.is_action_pressed("TouchScreen"):
		posClick = event.position

	if Input.is_action_just_released("TouchScreen"):
		if ClickInButton == false: return
		ClickInButton = false
		if isInArea != null:
			area.position = isInArea.global_position - area.get_parent().global_position
			line.set_point_position(1,isInArea.global_position - line.global_position)
			get_parent().CheckTrue()
			if isInArea == correctSpot.get_node("Area2D"):
				area.area_exited.disconnect(OutArea)
				isInArea.get_parent().Disconnect()
			return
		posClick = Vector2.ZERO
		area.position = Vector2.ZERO
		line.set_point_position(1,posClick)
		
		

func OnButton():
	ClickInButton = true
	isInArea = null

func _process(delta):
	if ClickInButton:
		line.set_point_position(1,posClick - line.global_position)
		area.global_position= posClick

func OnArea(x):
	if !x.is_in_group("Spot"): return
	isInArea = x 
	if x == correctSpot.get_node("Area2D"):
		CorrectArea()
	
func OutArea(x):
	isInArea = null
	isComplete = false
	button.button_down.connect(OnButton)

func resetAll():
	isInArea = null
	isComplete = false
	posClick = Vector2.ZERO
	area.position = Vector2.ZERO
	line.set_point_position(1,posClick)

func CorrectArea():
	isComplete = true
	button.button_down.disconnect(OnButton)
