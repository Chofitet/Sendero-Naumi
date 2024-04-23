extends CharacterBody2D

@export var PhantomCam : PhantomCamera2D
@export var max_speed = 100
@export var acceleration = 800
@export var friction = 800
@export var rotationSpeed = 5
@export var pcInventary : Control

@onready var particles = $Sprite2D/CPUParticles2D
@onready var particleCircle = preload("res://Scenes/Zona_Astronomia/particleAstronauta.tscn")
@onready var sprite = $Sprite2D
@onready var target_position = Vector2.ZERO
var direction: Vector2
var isPressing
var Meteoros :=[]
signal AllCollect
var isBlock = true

func _ready():
	$Area2D.area_entered.connect(GetPickUpObjects)
	$Area2D.area_entered.connect(SetSelfCamFollow)

func _physics_process(delta):
	Move(delta)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("TouchScreen"):
		if isBlock: return
		particles.emitting = true
		var particleInstance = particleCircle.instantiate()
		sprite.add_child(particleInstance)
		particleInstance.rotation = direction.angle()
		particleInstance.emitting = true
	if Input.is_action_pressed("TouchScreen"):
		if isBlock: return
		target_position= event.position
		isPressing = true
	if  Input.is_action_just_released("TouchScreen"):
		if isBlock: return
		particles.emitting = false
		isPressing = false
		direction = Vector2.ZERO

func Move(delta):
	if !isPressing:
		Apply_Friction(friction * delta)
	else:
		if !PhantomCam.outOfBounds:
			direction = (target_position - get_viewport_rect().get_center()).normalized()
		else: direction = (target_position - get_global_transform_with_canvas().get_origin()).normalized()
		
		RotateToDirectionSmoothly(delta)
		Apply_Movement(direction * acceleration * delta)
	
	move_and_slide()
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D or c.get_collider() is StaticBody2D:
			if c.get_collider().is_in_group("movible"):
				c.get_collider().apply_central_impulse(-c.get_normal() * 80)
			else: 
				var collision_info = move_and_collide(velocity * delta)
				if collision_info:
					velocity = velocity.bounce(collision_info.get_normal())
					
func Apply_Friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else: velocity = Vector2.ZERO
	
func Apply_Movement(accel):
	velocity += accel
	velocity = velocity.limit_length(max_speed)

func RotateToDirectionSmoothly(delta):
	var target_rotation = direction.angle()
	sprite.rotation = lerp_angle(sprite.rotation,target_rotation, rotationSpeed * delta)

func _get_follow_node_direction() -> Vector2:
	return direction

func GetPickUpObjects(x):
	if x.is_in_group("meteoro"):
		pcInventary.CheckMeteoro(GetMeteoroIndex(x))
		x.queue_free()
		Meteoros.append(x)
	
	if Meteoros.size() == 3:
		AllCollect.emit()

func GetMeteoroIndex(x)->int:
	if x.name == "Meteoroide":
		return 0
	elif  x.name == "meteoro":
		return 1
	elif x.name == "meteorito":
		return 2
	else: return 0

func BlockMove(x):
	isBlock = x

func SetSelfCamFollow(x):
	if x.is_in_group("FollowCam"):
		PhantomCam.set_follow_target_node(self)
		
