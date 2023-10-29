extends PathFollow2D

@export var speed : float
@export var buttonTap : Button
@export var TransformationEvent : AnimationPlayer
var active
var progressRatio = 0.0
signal Earthquake 

func _ready():
	get_node("Lava/AnimationPlayer").play("lava")

func _physics_process(delta):
	if active:
		progressRatio += speed * delta
		progressRatio = clamp(progressRatio, 0.0, 1.0) 
		set_progress_ratio(progressRatio)
	else:
		progressRatio -= speed * delta
		progressRatio = clamp(progressRatio, 0.0, 1.0) 
		set_progress_ratio(progressRatio)
	if get_progress_ratio() > 0.3:
		Earthquake.emit()
	if get_progress_ratio() == 1:
		buttonTap.visible = false
		TransformationEvent.play("Transformation")

func _on_tap_button_up():
	active = false

func _on_tap_button_down():
	active = true
