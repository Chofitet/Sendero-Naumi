extends Node
var instance
var soundBank 
var isMute
var CuttableQueue : = []

func _ready():
	soundBank = get_child(0)


func PlayEvent(eventName : String, delay : float = 0, isCuttable = false):
	if isMute: return
	var timer = get_tree().create_timer(delay)
	await  timer.timeout
	if !isCuttable: SoundManager.play(soundBank.label,eventName)
	elif isCuttable: 
		var instanceSound = SoundManager.instance_poly(soundBank.label, eventName)
		instanceSound.trigger()
		CuttableQueue.append(instanceSound)
		var _timer = get_tree().create_timer(5)
		_timer.timeout.connect(StopInSoundTime.bind(instanceSound))


func PlayLoopEvent(loopEventName : String):
	if isMute: return
	instance = SoundManager.instance_poly(soundBank.label, loopEventName)
	instance.trigger()

func StopLoopSound():
	instance.release()

func SetMute(x:bool):
	isMute = x

func StopSoundsInCuttableQueue():
	for s in CuttableQueue:
		s.release()

func StopInSoundTime(s):
	if s == null: return
	s.release()

