extends CharacterBody2D
var pressedPos: Vector2
var topo 
var particles
var raycast : RayCast2D
var isMoving 
@export var initPos : Marker2D
@export var SecondPos : Marker2D
@export var PointWay : Marker2D
@export var instance1 : Control
@export var instance2 : Control
@export var Color1 : Color
@export var Color2 : Color
@export var speed : float
@export var cam : Camera2D
var _speed 
@export var line : Line2D
var collision_line = preload("res://Scenes/Zona_Megafauna/line_collider.tscn")
@onready var timer = $Timer
var relative_position 
var isStoped

func _ready():
	_speed = speed
	timer.timeout.connect(SpawnCollider)
	topo = $topo
	particles = $topo/MoleParticles
	raycast = $topo/RayCast2D
	EnableDisaneable(false)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("TouchScreen"):
		isMoving = true 
		timer.start()
		if isStoped: return
		particles.emitting = true
		topo.get_node("topo").play("move")
	if Input.is_action_pressed("TouchScreen"):
		pressedPos = get_global_mouse_position()
	if Input.is_action_just_released("TouchScreen"):
		timer.stop()
		isMoving = false
		particles.emitting = false
		topo.get_node("topo").play("idle")

func _physics_process(delta):
	if !isMoving: return
	relative_position = global_position - line.global_position 
	var direction = (pressedPos - global_position).normalized()
	if topo.global_position.distance_to(pressedPos) > 110 :
		Apply_Movement(direction * 8000 * delta)
		move_and_slide()
		line.add_point(relative_position)
	if !isStoped and _speed != 0:
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

func EnableDisaneable(state,resetInstance:bool = false):
	if !state:
		topo.get_node("topo").play("idle")
		particles.emitting = false
		isStoped = true
		_speed = 0
	else :
		isStoped = false
		_speed = speed
	
	if resetInstance:
		position = SelectInscancePosition()
		topo.rotation = deg_to_rad(SelectInstanceRotation())
		print(SelectInstanceRotation())
		line.clear_points()
		cam.RestartPos()
		for c in line.get_children():
			c.queue_free()
		line.add_point(PointWay.position - line.global_position)
		line.add_point(global_position - line.global_position + Vector2(10,10))

func SelectInscancePosition() -> Vector2:
	if instance1.visible:
		return initPos.position
	if instance2.visible:
		return SecondPos.position
	return Vector2.ZERO

func SelectInstanceRotation() -> float:
	if instance1.visible:
		return 39
	if instance2.visible:
		return -20
	return 0 

func ConnectBook(instance):
	instance.BookEvent.connect(EnableDisaneable)
