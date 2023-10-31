extends PathFollow2D

@export var speed : float
var active
var progressRatio = 0.0
signal CompletePath
var once

func _ready():
	get_node("Lava/AnimationPlayer").play("lava")

func _physics_process(delta):
	if active:
		progressRatio += speed * delta
		progressRatio = clamp(progressRatio, 0.0, 1.0) 
		set_progress_ratio(progressRatio)
	if get_progress_ratio() == 1:
		if !once:
			CompletePath.emit()
			once = true

func ActivateLava():
	active = true
	get_node("Lava").visible = true

