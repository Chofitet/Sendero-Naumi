extends RigidBody2D

var breakingScene = preload("res://Scenes/Experiments/BreakingRock.tscn")

@export var instanceParent : Node2D

func _ready():
	get_node("Area2D").body_entered.connect(_on_area_2d_body_entered)

func _on_area_2d_body_entered(body):
	if body.is_in_group("BreakingTrigger"):
		SpawnOnDeath(breakingScene)

func SpawnOnDeath(instancia):
	var breakingInstance = instancia.instantiate()
	get_parent().call_deferred("add_child",breakingInstance)
	var breakingPices = breakingInstance.get_children()
	for p in breakingPices: 
		p.position = p.position + position
		p.linear_velocity = Vector2(0,0)
		p.linear_velocity = linear_velocity * 0.5
		p.angular_velocity = angular_velocity 
	#get_tree().current_scene.call_deferred("add_child", breakingInstance)
	queue_free()

func SetFreeze():
	freeze = false
