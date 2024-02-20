extends Node2D
var isTouchin
@export var DistantThreshold : float
@onready var spawnArea = $SpawnArea

var first_touch_position : Vector2

func _input(event):
	if Input.is_action_just_pressed("TouchScreen"):
		var first_touch_position = event.position
	if Input.is_action_pressed("TouchScreen"):
		await get_tree().create_timer(0.2).timeout
		var last_touch_position = event.position
		if abs(first_touch_position.length() - last_touch_position.length()) > DistantThreshold:
			spawnArea.Spawn()
		first_touch_position = event.position
