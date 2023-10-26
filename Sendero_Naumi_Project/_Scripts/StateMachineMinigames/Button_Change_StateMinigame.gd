extends Button

@export var state_to_change : StateMinigame
@export var state_machine : Node

func _on_pressed():
	state_machine.Trigger_On_Child_Transition(state_to_change.name)

