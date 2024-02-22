extends Node2D
var isTouchin
@export var DistantThreshold : float
@onready var spawnArea = $SpawnArea
var _isPressing

var first_touch_position : Vector2

func _input(event):
	if Input.is_action_just_pressed("TouchScreen"):
		if !_isPressing: return
		var first_touch_position = event.position
	if Input.is_action_pressed("TouchScreen"):
		if !_isPressing: return
		await get_tree().create_timer(0.2).timeout
		var last_touch_position = event.position
		if abs(first_touch_position.length() - last_touch_position.length()) > DistantThreshold:
			if last_touch_position.y > first_touch_position.y:
				var aux = abs(last_touch_position.y - first_touch_position.y)
				if aux > DistantThreshold * 2:
					spawnArea.Spawn()
					spawnArea.Spawn()
					spawnArea.Spawn()
		first_touch_position = event.position

func isPressing(x):
	_isPressing = x
