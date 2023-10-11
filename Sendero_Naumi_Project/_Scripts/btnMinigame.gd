extends Sprite2D
@export var LevelNumber : int
var Argentina_Flag
var button

func _ready():
	Argentina_Flag = "res://Sprites/argentina_Flag.png"
	visible = false
	button = get_node("ButtonChangeScene")

func _physics_process(delta):
	if PlayerVariables.MinigameStage == LevelNumber:
		visible = true
	elif PlayerVariables.MinigameStage > LevelNumber: 
		visible = true
		texture = load(Argentina_Flag)
		button.disabled  = true
	
	



