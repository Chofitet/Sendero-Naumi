extends CharacterBody2D

@export var PhantomCam : PhantomCamera2D
@export var max_speed = 100
@export var acceleration = 800
@export var friction = 800
@export var rotationSpeed = 5
@export var pcInventary : Control
var CrashForce : Vector2 = Vector2.ONE
@onready var particles = $Sprite2D/CPUParticles2D
@onready var particleCircle = preload("res://Scenes/Zona_Astronomia/particleAstronauta.tscn")
@onready var sprite = $Sprite2D
@onready var target_position = Vector2.ZERO
@onready var textureIdle = preload("res://Sprites/ZonaAstronomia/astronauta - astronauta.png")
@onready var texturePropulsion = preload("res://Sprites/ZonaAstronomia/astronauta propuIsion - astronauta.png")
var direction: Vector2
var lastdirection : Vector2
var isCrash
var isPressing
var Meteoros :=[]
signal AllCollect
var isBlock = true
signal collision
@onready var Collision_Timer : Timer = $Timer
var SoundJP
var breatheSound
var Pressed = false

func _ready():
	$Area2D.area_entered.connect(GetPickUpObjects)
	$Area2D.area_entered.connect(SetSelfCamFollow)
	Collision_Timer.timeout.connect(RestartCollisionDetector)

func _physics_process(delta):
	Move(delta)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("TouchScreen"):
		Pressed = true
		if isBlock: 
			particles.emitting = false
			return
		sprite.texture = texturePropulsion
		particles.emitting = true
		SoundManager.play("astronauta","fart")
		if SoundJP == null :
			SoundJP = SoundManager.instance_poly("astronauta", "jetpack")
			SoundJP.trigger()
		var particleInstance = particleCircle.instantiate()
		sprite.add_child(particleInstance)
		particleInstance.rotation = direction.angle()
		particleInstance.emitting = true
	if Input.is_action_pressed("TouchScreen"):
		if isBlock:
			particles.emitting = false
			if SoundJP != null: 
				SoundJP.release()
				SoundJP = null
			return
		target_position= event.position
		isPressing = true
	if  Input.is_action_just_released("TouchScreen"):
		Pressed = false
		if SoundJP != null: 
			SoundJP.release()
			SoundJP = null
		if isBlock: 
			particles.emitting = false
			return
		sprite.texture = textureIdle
		particles.emitting = false
		isPressing = false
		direction = Vector2.ZERO

var last_collider 

func Move(delta):
	if !isPressing:
		Apply_Friction(friction * delta)
	else:
		direction = (target_position - get_global_transform_with_canvas().get_origin()).normalized()
		
		RotateToDirectionSmoothly(delta)
		Apply_Movement(direction * acceleration * delta * CrashForce)
		lastdirection = direction
	
	if isCrash:
		Apply_Movement(lastdirection * acceleration * delta * -1 * 800)
	
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
				
				if last_collider == null:
					Collision_Timer.start()
					last_collider = c.get_collider()
					SoundManager.play("astronauta","hit")
					collision_count += 1
					collision.emit(str(collision_count),1)
					print(collision_count)


func RestartCollisionDetector():
	last_collider = null

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

var collision_count = 0

func GetPickUpObjects(x):
	if x.is_in_group("meteoro"):
		#SoundManager.play("astronauta","pickUp")
		if Meteoros.find(x.name) == -1:
			Meteoros.append(x.name)
			pcInventary.CheckMeteoro(GetMeteoroIndex(x))
		
		x.queue_free()
	
	
	if Meteoros.size() == 3:
		AllCollect.emit()
		BlockMove(true)
		isPressing = false

func GetMeteoroIndex(x)->int:
	if x.name == "Meteoroide":
		return 0
	elif  x.name == "meteoro":
		return 1
	elif x.name == "meteorito":
		return 2
	else: return 0

func BlockMove(x,SetPressing = false):
	isBlock = x
	if !Pressed : return
	if (isPressing and isBlock == false) or SetPressing:
		if !wasPressing: isPressing = true
		particles.emitting = true
		if SoundJP == null :
			SoundJP = SoundManager.instance_poly("astronauta", "jetpack")
			SoundJP.trigger()

func SetSelfCamFollow(x):
	if x.is_in_group("FollowCam"):
		PhantomCam.set_follow_target_node(self)
		

var wasPressing = false
func DoCrash():
	BlockMove(true)
	if isPressing: wasPressing = true
	isPressing = false
	isCrash = true
	var tween = get_tree().create_tween()
	tween.tween_property(sprite,"rotation_degrees", sprite.rotation_degrees + 360*3,2)
	await tween.finished
	if wasPressing:
		isPressing = true
		wasPressing = false
	isCrash = false
	BlockMove(false)
