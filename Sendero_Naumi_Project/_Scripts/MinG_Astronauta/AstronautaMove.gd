extends CharacterBody2D


@export var max_speed = 100
@export var acceleration = 800
@export var friction = 800
@export var rotationSpeed = 5

@onready var sprite = $Sprite2D
@onready var target_position = Vector2.ZERO
var direction: Vector2
var isPressing
var Meteoros :=[]
signal AllCollect

func _ready():
	$Area2D.area_entered.connect(GetPickUpObjects)

func _physics_process(delta):
	Move(delta)

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("TouchScreen"):
		target_position= event.position
		isPressing = true
	if  Input.is_action_just_released("TouchScreen"):
		isPressing = false
		direction = Vector2.ZERO

func Move(delta):
	if !isPressing:
		Apply_Friction(friction * delta)
	else:
		direction = (target_position - get_viewport_rect().get_center()).normalized()
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
		x.queue_free()
		Meteoros.append(x)
		print(Meteoros.size())
	
	if Meteoros.size() == 3:
		AllCollect.emit()
	