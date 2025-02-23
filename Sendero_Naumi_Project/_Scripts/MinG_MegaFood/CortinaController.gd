extends Node2D
@export var Pos : Marker2D
@export var StateMachine : Node
var once : bool
signal arrive

func _ready():
	$Button.Down.connect(AnimatedToPos)

func AnimatedToPos():
	if once: return
	once = true
	$Button.visible = false
	var tween = get_tree().create_tween()
	tween.tween_property(self,"global_position", Pos.global_position, 1).set_ease(Tween.EASE_OUT_IN)
	await tween.finished
	$cordon/SquigglingSprite.InactiveSquiggling()
	instanciateFade()

func instanciateFade():
	arrive.emit()
	var fadeInstance = load("res://Scenes/Experiments/IndividualFade.tscn")
	var texture = load("res://addons/scene_manager/shader_patterns/diagonal.png")
	var instance = fadeInstance.instantiate()
	PlayerVariables.EmitInactivePause()
	$fade.add_child(instance)
	instance.init(texture,2,true)
	await get_tree().create_timer(2).timeout
	StateMachine.Trigger_On_Child_Transition("Fin")
	var instance2 = fadeInstance.instantiate()
	$fade.add_child(instance2)
	instance2.init(texture,2,false,false)

func PlayCordonAppear():
	$AnimationPlayer.play("cordon_anim")

var initial_offset = Vector2.ZERO

func _input(event):
	if $Button.visible == false : return
	if Input.is_action_just_pressed("TouchScreen"):
		var target_position = event.position
		initial_offset = target_position - global_position

	if Input.is_action_pressed("TouchScreen"):
		var target_position = event.position
		var new_position = target_position.y - initial_offset.y

		if new_position > global_position.y:
			global_position.y = new_position
		print(new_position - initial_offset.y)
		if new_position - initial_offset.y > 80:
			AnimatedToPos()
