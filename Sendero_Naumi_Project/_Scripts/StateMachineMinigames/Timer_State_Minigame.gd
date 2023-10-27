extends Timer

@export var state_to_change : StateMinigame
@export var state_machine : Node
@export var isEndOfGame : bool
signal EndOfGame

func _on_timeout():
	state_machine.Trigger_On_Child_Transition(state_to_change.name)
	if isEndOfGame:
		self.visible = false
		EndOfGame.emit()

