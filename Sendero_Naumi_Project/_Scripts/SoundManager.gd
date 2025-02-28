extends Node
var queueLoopedSound =[]

func Play_Sound(stream : AudioStream):
	var instance = AudioStreamPlayer.new()
	instance.stream = stream
	instance.finished.connect(remove_sound.bind(instance))
	add_child(instance)
	instance.play()

func Play_Loop_Sound(stream : AudioStream):
	var instance = AudioStreamPlayer.new()
	instance.stream = stream
	add_child(instance)
	queueLoopedSound.add(queueLoopedSound)

func remove_sound(instance):
	instance.queue_free()

func remove_looped_sound(stream: AudioStream):
	for s in queueLoopedSound:
		if s.stream == stream:
			remove_sound(s)
