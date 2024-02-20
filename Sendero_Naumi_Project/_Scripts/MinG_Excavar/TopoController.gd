extends CharacterBody2D
var pressedPos: Vector2
var topo 
var particles
var raycast : RayCast2D
var isMoving 
var toStopMoveAnim : bool = false
@export var Color1 : Color
@export var Color2 : Color
@export var speed : float
@export var line : Line2D
var collision_line = load("res://Scenes/Zona_Megafauna/line_collider.tscn")


func _ready():
	topo = $topo
	#topo.get_node("topo").animation_looped.connect(AnimationLoopFinished)
	particles = $topo/MoleParticles
	raycast = $topo/RayCast2D

#func AnimationLoopFinished():
#	print("loop")
#	if toStopMoveAnim:
#		topo.get_node("topo").play("idle")
#		toStopMoveAnim = false


func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("TouchScreen"):
		isMoving = true 
		pressedPos = event.position
		particles.emitting = true
		topo.get_node("topo").play("move")
	if Input.is_action_just_released("TouchScreen"):
		isMoving = false
		particles.emitting = false
		topo.get_node("topo").play("idle")
		toStopMoveAnim = true
		

func _process(delta):
	if !isMoving: return
	if abs(topo.global_position.length() - pressedPos.length()) < 5 : return
	var relative_position = global_position - line.global_position 
	var direction = (pressedPos - global_position).normalized()
	
	
	Apply_Movement(direction * 8000 * delta)
	move_and_slide()
	topo.look_at(pressedPos)
	line.add_point(relative_position)
	var line_instance_collider = collision_line.instantiate()
	line_instance_collider.position = relative_position
	line.add_child(line_instance_collider)
	
	CheckIsInLine()

func Apply_Movement(accel):
	velocity += accel
	velocity = velocity.limit_length(speed)

func CheckIsInLine():
	if !raycast.get_collider() : 
		particles.color = Color1
		return
	var collision = raycast.get_collider()
	if collision.is_in_group("line"):
		particles.color = Color2
	else:
		particles.color = Color1
