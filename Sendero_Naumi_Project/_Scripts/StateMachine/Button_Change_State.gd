extends Button

@export var state_to_change : State
@export var state_machine : Node

func _ready():
	pressed.connect(_on_pressed)

func _on_pressed():
	state_machine.Trigger_On_Child_Transition(state_to_change.name)
