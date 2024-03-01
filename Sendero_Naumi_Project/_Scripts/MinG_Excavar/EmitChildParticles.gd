extends Node2D
var particles :=[]

func _ready():
	for p in get_children():
		particles.append(p)

func Emit():
	for p in particles:
		p.emitting = true
