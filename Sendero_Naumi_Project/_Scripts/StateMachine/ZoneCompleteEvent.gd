extends State
class_name ZoneCompleteEvent

func Enter():
	get_parent().get_node("ButtonBack").visible = false
	get_node("ColorRect2").visible = true
	get_node("Timer").start()

func _on_timer_timeout():
	get_node("ColorRect2").visible = false
	get_parent().Trigger_On_Child_Transition("NoZone")
	PlayerVariables.lastState = "NoZone"
