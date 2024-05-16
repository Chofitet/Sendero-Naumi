extends RigidBody2D

var breakingScene = preload("res://Scenes/Experiments/BreakingRock.tscn")
@export var _Color : Color
@export var instanceParent = "BreakingTrigger"
@export var group : String

func _ready():
	modulate = _Color
	get_node("Area2D").body_entered.connect(_on_area_2d_body_entered)
	get_node("Area2D").area_entered.connect(breakRock)

func _on_area_2d_body_entered(body):
	if body == self: return
	if body.is_in_group(group):
		SpawnOnDeath(breakingScene)

func breakRock(x):
	if x.is_in_group(group):
		SpawnOnDeath(breakingScene)

func SpawnOnDeath(instancia):
	var breakingInstance = instancia.instantiate()
	get_parent().call_deferred("add_child",breakingInstance)
	var breakingPices = breakingInstance.get_children()
	for p in breakingPices: 
		p.position = p.position + position
#		p.linear_velocity = Vector2(0,0)
#		##p.modulate = _Color
#		p.linear_velocity = linear_velocity * 0.5
#		p.angular_velocity = angular_velocity 
#	#get_tree().current_scene.call_deferred("add_child", breakingInstance)
	queue_free()

func UnFreeze():
	freeze = false

func Freeze():
	freeze = true
