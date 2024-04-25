extends CharacterBody2D
var target_point
var direction
var acceleration = 800

func applyForce(body, target):
	target_point = (target.global_position - global_transform.origin).normalized()
	direction = body.get_parent().lastdirection
	await get_tree().create_timer(0.5).timeout
	direction = target_point
	acceleration = 2000

func _process(delta):
	Apply_Movement(direction * delta * acceleration)
	move_and_slide()

func Apply_Movement(accel):
	velocity += accel
	velocity = velocity.limit_length(8000)

