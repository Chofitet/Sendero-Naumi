extends Node
var instance
var soundBank 
var isMute
var CuttableQueue : = []
@export var poolOfSounds : Array[String]
var numOfSounds
var _timer

func _ready():
	soundBank = get_child(0)
	numOfSounds = poolOfSounds.size()


func PlayEvent(eventName : String, delay : float = 0, isCuttable = false):
	if isMute: return
	var timer = get_tree().create_timer(delay)
	await  timer.timeout
	if !isCuttable: SoundManager.play(soundBank.label,eventName)
	elif isCuttable: 
		var instanceSound = SoundManager.instance_poly(soundBank.label, eventName)
		instanceSound.trigger()
		CuttableQueue.append(instanceSound)
		_timer = get_tree().create_timer(5)
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
	if _timer != null: _timer.timeout.disconnect(StopInSoundTime)
	for s in CuttableQueue:
		s.release()

func StopInSoundTime(s):
	if s == null: return
	s.release()

var once
func EmitPoolOfSound():
	if once : return
	once = true
	var sound = poolOfSounds[numOfSounds -1]
	SoundManager.play(soundBank.label,sound)
	numOfSounds -= 1
	if numOfSounds == 0: numOfSounds = poolOfSounds.size()
	await get_tree().create_timer(0.3).timeout
	once = false
