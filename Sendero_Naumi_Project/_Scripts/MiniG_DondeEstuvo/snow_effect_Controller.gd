extends Node2D
var windTrial = load("res://Scenes/Experiments/windTrial/WindTrial.tscn")

func _ready():
	$Timer.timeout.connect(SpawnWindTrial)

func SpawnWindTrial():
	var WT = windTrial.instantiate()
	add_child(WT)
	WT._ready()
	WT.position = Vector2(-72,0)
