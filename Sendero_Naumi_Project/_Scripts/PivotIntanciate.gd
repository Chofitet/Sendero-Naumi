extends Node2D

@export var scene : PackedScene
@export var timeToDestroy : float

func Instanciate():
	var instance = scene.instantiate()
	add_child(instance)
	if instance is CPUParticles2D:
		instance.emitting = true
	if timeToDestroy != 0:
		await  get_tree().create_timer(timeToDestroy).timeout
		instance.queue_free()
