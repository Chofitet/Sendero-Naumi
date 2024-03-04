extends CharacterBody2D
var pressedPos: Vector2
var topo 
var particles
var raycast : RayCast2D
var isMoving 
var initPos 
var toStopMoveAnim : bool = false
@export var Color1 : Color
@export var Color2 : Color
@export var speed : float
var _speed 
@export var line : Line2D
var collision_line = load("res://Scenes/Zona_Megafauna/line_collider.tscn")
@onready var timer = $Timer
var relative_position 

func _ready():
	_speed = speed
	#timer.timeout.connect(SpawnCollider)
	topo = $topo
	initPos = topo.position
	particles = $topo/MoleParticles
	raycast = $topo/RayCast2D
	

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("TouchScreen"):
		timer.start()
	if Input.is_action_pressed("TouchScreen"):
		isMoving = true 
		pressedPos = get_global_mouse_position()
		particles.emitting = true
		topo.get_node("topo").play("move")
	if Input.is_action_just_released("TouchScreen"):
		timer.stop()
		isMoving = false
		particles.emitting = false
		topo.get_node("topo").play("idle")
		toStopMoveAnim = true

func _process(delta):
	if !isMoving: return
	relative_position = global_position - line.global_position 
	var direction = (pressedPos - global_position).normalized()
	if topo.global_position.distance_to(pressedPos) > 110 :
		Apply_Movement(direction * 8000 * delta)
		move_and_slide()
		line.add_point(relative_position)
	topo.look_at(pressedPos)
	

func Apply_Movement(accel):
	velocity += accel
	velocity = velocity.limit_length(_speed)

func SpawnCollider():
	var line_instance_collider = collision_line.instantiate()
	line_instance_collider.position = relative_position
	line.add_child(line_instance_collider)

	CheckIsInLine()

func CheckIsInLine():
	if !raycast.get_collider() : 
		particles.color = Color1
		return
	var collision = raycast.get_collider()
	if collision.is_in_group("line"):
		particles.color = Color2
	else:
		particles.color = Color1

func EnableDisaneable(x):
	visible = x
	if !x:
		_speed = 0

func Reset():
	visible = true
	_speed = speed
	topo.position = initPos
	line.clear_points()
	for c in line.get_children():
		c.queue_free()
