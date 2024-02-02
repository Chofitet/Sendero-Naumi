extends RigidBody2D

var BreakingSmallScene = preload("res://Scenes/Experiments/BreakingSmallRock.tscn")
@export var instanceParent : Node2D

func _ready():
	get_node("Area2D").area_entered.connect(_on_area_2d_body_entered)

func _on_area_2d_body_entered(body):
	if body.is_in_group("BreakingSmallTrigger"):
		SpawnOnDeath()

func SpawnOnDeath():
	var breakingInstance = BreakingSmallScene.instantiate()
	get_parent().call_deferred("add_child",breakingInstance)
	var breakingPices = breakingInstance.get_children()
	for p in breakingPices: 
		p.position = p.position + position
		p.linear_velocity = Vector2(0,0)
		p.modulate = modulate
		p.linear_velocity = linear_velocity * 0.5
	#get_tree().current_scene.call_deferred("add_child", breakingInstance)
	queue_free()

func UnFreeze():
	freeze = false
