extends Node
var current_state : StateMinigame
var states : Dictionary = {}
signal StateUpdate
@export var initial_state : StateMinigame

func _ready():
	self.StateUpdate.connect(Trigger_On_Child_Transition)
	for child in get_children():
		if child is StateMinigame:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(On_Child_Transition)
	if initial_state:
		initial_state.Enter()
		current_state = initial_state
	
func _process(delta):
	if current_state:
		current_state.Update(delta)

func _physics_process(delta):
		if current_state:
			current_state.Update(delta)

func On_Child_Transition(state, new_state_name, incruiseLevel = false):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower()) 
	if !new_state: 
		return
	
	if current_state:
		current_state.Exit(incruiseLevel)
		
	new_state.Enter()
	current_state = new_state

func Trigger_On_Child_Transition(new_state_name, incruiseLevel = false):
	On_Child_Transition(current_state, new_state_name, incruiseLevel)

