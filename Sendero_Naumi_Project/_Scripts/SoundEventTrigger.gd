extends Node
var instance
var soundBank 

func _ready():
	soundBank = get_child(0)


func PlayEvent(eventName : String, delay : float = 0):
	var timer = get_tree().create_timer(delay)
	await  timer.timeout
	SoundManager.play(soundBank.label,eventName)

func PlayLoopEvent(loopEventName : String):
	instance = SoundManager.instance_poly(soundBank.label, loopEventName)
	instance.trigger()

func StopLoopSound():
	instance.release()
