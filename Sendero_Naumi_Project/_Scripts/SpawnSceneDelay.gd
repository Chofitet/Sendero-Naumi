extends Control

var Scene = preload("res://Scenes/UI_Scenes/naumi_controller.tscn")
signal NaumiPress

func _ready():
	await  get_tree().create_timer(3).timeout
	var instance = Scene.instantiate()
	instance.ButtonPress.connect(BTNPress)
	add_child(instance)
	
	instance.position = Vector2(0, 0)

func BTNPress():
	NaumiPress.emit()
