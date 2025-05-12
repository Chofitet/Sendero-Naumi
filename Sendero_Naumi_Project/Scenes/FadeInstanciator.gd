extends CanvasLayer

var Fade = preload("res://Scenes/Experiments/IndividualFade.tscn")
@export var fadeTexture = preload("res://addons/scene_manager/shader_patterns/diagonal.png")
signal fadeInFinish
signal fadeOutStart
@export var time : float = 1 

func InstanciateFade():
	PlayerVariables.EmitInactivePause()
	var instance = Fade.instantiate()
	add_child(instance)
	instance.init(fadeTexture,time,true)
	await get_tree().create_timer(time).timeout
	fadeInFinish.emit()
	fadeOutStart.emit()
	var instance2 = Fade.instantiate()
	add_child(instance2)
	instance2.init(fadeTexture,time,false,false)
	PlayerVariables.EmitActivePause()
