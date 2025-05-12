extends Node2D
@export var Pos : Marker2D
@export var StateMachine : Node
@export var limitGesture : float
var once : bool
signal arrive
var inGesture
var hold
var releasePos
var pressedPos
var target_position
var numTry = 0
var inButton
var isVerticalGesture
signal Fuerzaaa
signal ExitFuerzaaa
signal Closing

func _ready():
	$Timer.timeout.connect(calculateGesture)
	$Timer.timeout.connect(TryHold)
	$Button.button_down.connect(SetInButton)
	$Button.button_up.connect(pulse)
	pass
	#$Button.Down.connect(AnimatedToPos)

func SetInButton():
	inButton = true
	$Timer.start()
	hold = true
	inGesture = true
	SoundManager.play("cordon","tap")

func pulse():
	if hold: return
	if abs(pressedPos.y - target_position.y) <= 500 :
		if numTry == 2:
			Fuerzaaa.emit()
		numTry +=1
	

func AnimatedToPos():
	if once: return
	SoundManager.play("cordon","close")
	Closing.emit()
	if numTry >=2: ExitFuerzaaa.emit()
	once = true
	$Button.visible = false
	var tween = get_tree().create_tween()
	tween.tween_property(self,"global_position", Pos.global_position, 1).set_ease(Tween.EASE_OUT_IN)
	await tween.finished
	$cordon/SquigglingSprite.InactiveSquiggling()
	instanciateFade()

func instanciateFade():
	arrive.emit()
#	var fadeInstance = load("res://Scenes/Experiments/IndividualFade.tscn")
#	var texture = load("res://addons/scene_manager/shader_patterns/diagonal.png")
#	var instance = fadeInstance.instantiate()
#	PlayerVariables.EmitInactivePause()
#	$fade.add_child(instance)
#	instance.init(texture,2,true)
#	await get_tree().create_timer(2).timeout
	StateMachine.Trigger_On_Child_Transition("Fin")
#	var instance2 = fadeInstance.instantiate()
#	$fade.add_child(instance2)
#	instance2.init(texture,2,false,false)

func PlayCordonAppear():
	$AnimationPlayer.play("cordon_anim")

var initial_offset = Vector2.ZERO

func _input(event):
	if $Button.visible == false : return
	if Input.is_action_just_pressed("TouchScreen"):
		pressedPos = event.position
		
#		var target_position = event.position
#		initial_offset = target_position - global_position

	if Input.is_action_pressed("TouchScreen"):
		target_position = event.position
		
		var d = pressedPos - target_position
		
		if abs(d.y) > abs(d.x):
			if d.y < 0: 
				isVerticalGesture = true
			else:
				isVerticalGesture = false
		else:
			isVerticalGesture = false
		
#		var new_position = target_position.y - initial_offset.y
#		if new_position > global_position.y:
#			global_position.y = new_position
#		print(new_position - initial_offset.y)
#		if new_position - initial_offset.y > Pos.global_position.y - 400:
#			AnimatedToPos()
	
	if  Input.is_action_just_released("TouchScreen"):
		hold = false
		releasePos = event.position
		inButton = false

func calculateGesture() -> void:
	if !isVerticalGesture: return
	if !inGesture : return 
	inGesture = false
	if hold: return
	var d 
	d= releasePos - pressedPos
	#if (abs(d.x) < limitGesture) :	return
	if abs(d.y) > abs(d.x):
		if d.y > 0:
			AnimatedToPos()

func TryHold():
	if !isVerticalGesture: return
	if !hold: return
	if abs(pressedPos.y - target_position.y) >= 500 : 
		AnimatedToPos()
		return
	if numTry == 2:
		Fuerzaaa.emit()
	numTry +=1
	$Button.visible = false
	SoundManager.play("cordon","tryClose")
	var anim : AnimationPlayer = $AnimationPlayer
	anim.play("cordon_try")
	await anim.animation_finished
	$Button.visible = true
