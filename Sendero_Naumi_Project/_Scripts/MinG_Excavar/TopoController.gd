extends CharacterBody2D
var pressedPos: Vector2
var topo
var isMoving 
@export var speed : float
@export var line : Line2D

func _ready():
	topo = $topo
	

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("TouchScreen"):
		isMoving = true 
		pressedPos = event.position
	if Input.is_action_just_released("TouchScreen"):
		isMoving = false
		

func _process(delta):
	if !isMoving: return
	if abs(topo.global_position.length() - pressedPos.length()) < 5 : return
	var relative_position = global_position - line.global_position 
	var direction = (pressedPos - global_position).normalized()
	print(relative_position)
	
	Apply_Movement(direction * 8000 * delta)
	move_and_slide()
	topo.look_at(pressedPos)
	line.add_point(relative_position)

func Apply_Movement(accel):
	velocity += accel
	velocity = velocity.limit_length(speed)
