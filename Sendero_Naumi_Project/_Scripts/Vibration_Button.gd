extends Node
@export var vibrate : float


func _on_pressed():
	Input.vibrate_handheld(vibrate)
  
