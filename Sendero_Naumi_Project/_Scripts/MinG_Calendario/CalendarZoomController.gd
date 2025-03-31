extends Control
@onready var CalendarPivot = $calendarPivot
@onready var Circle = $calendarPivot/Calendar/Circulo
@export var PanelConsigna : Panel
var Positions :=[]
var QButtons :=[]
@onready var InstanceController = get_parent().get_parent()
var OffsetSpot
var gamefinished
signal ZoomFinished
signal ZoomOutFinished
signal OutroAnim
var pop = preload("res://Scenes/UI_Scenes/pop.tscn")

func _ready():
	for p in $calendarPivot/Calendar.get_children():
		Positions.append(p)
	OffsetSpot = get_parent().get_parent().get_node("Spot").global_position - global_position
	var i = 1
	for q in $Buttons.get_children():
		QButtons.append(q)
		q.get_node("Button").pressed.connect(ZoomToPos.bind(i))
		i += 1
	await get_tree().create_timer(3).timeout

func SetQuestionWithInstance():
	for i in range(0,InstanceController.get_num_instance()):
		QButtons[i].visible = false
	QButtons[InstanceController.get_num_instance()].get_node("anim").play("blink")

func ZoomToPos(index = 0):
	for q in $Buttons.get_children():
		if q != QButtons[index-1]: 
			q.visible = false
			continue
		q.get_node("anim").play("tap")
	await get_tree().create_timer(0.5).timeout
	$Buttons.visible = false
	if index != 0:
		QButtons[index-1].visible = false
		QButtons[index].get_node("anim").play("blink")
	FocusCircle(index)
	await get_tree().create_timer(1).timeout
	if index == 0 : $calendarPivot/Calendar.material.set_shader_parameter("focus_radius", 2)
	Circle.visible = false
	if index != 0 :
		$calendarPivot/Calendar.material.set_shader_parameter("focus_point", get_Circle_Offset2(index))
		$calendarPivot/Calendar.material.set_shader_parameter("focus_radius", 0.034)
	if index == 6: $calendarPivot/Calendar.material.set_shader_parameter("focus_radius", 0.077)
	await get_tree().create_timer(0.3).timeout
	if index == 0 : if gamefinished: OutroAnim.emit()
	var posToMove = Positions[index].position 
	var tween = get_tree().create_tween()
	tween.tween_property(CalendarPivot.get_node("Calendar"), "offset", -posToMove,1).set_ease(Tween.EASE_IN)
	var ZoomTween = get_tree().create_tween()
	if index != 0:
		PanelConsigna.ExitPanel()
		if index != 6:
			ZoomTween.tween_property(CalendarPivot.get_node("Calendar"),"scale", Vector2(12,12),1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_EXPO)
		else: 
			ZoomTween.tween_property(CalendarPivot.get_node("Calendar"),"scale", Vector2(5.2,5.2),1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_EXPO)
	else:
		if !gamefinished: PanelConsigna.EnterPanel()
		ZoomTween.tween_property(CalendarPivot.get_node("Calendar"),"scale", Vector2(1,1),1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	
	await tween.finished
	if index == 0 : 
		$Buttons.visible = true
		if gamefinished: 
			ZoomOutFinished.emit()
			PlayerVariables.EmitInactivePause()
	else: 
		ZoomFinished.emit()


func FocusCircle(index):
	var tween = get_tree().create_tween()
	if index == 0 : 
		tween.tween_method(TweenInsedeFocusCircle,0.012,0.3,0.95)
	else:
		Circle.visible = true
		Circle.material.set_shader_parameter("focus_point", get_Circle_Offset(index))
		if index == 6:
			tween.tween_method(TweenFocusParameter,0.6,0.027,1).set_ease(Tween.EASE_IN)
		else:
			tween.tween_method(TweenFocusParameter,0.6,0.01,1).set_ease(Tween.EASE_IN)
		await tween.finished
	

func TweenInsedeFocusCircle(value):
	$calendarPivot/Calendar.material.set_shader_parameter("focus_radius", value)

func TweenFocusParameter(value):
	Circle.material.set_shader_parameter("focus_radius", value)

func get_Circle_Offset(index) -> Vector2:
	match index:
		0: return Vector2(2,2)
		1: return Vector2(0.354,0.414)
		2: return Vector2(0.39,0.488)
		3: return Vector2(0.547,0.453)
		4: return Vector2(0.482,0.47)
		5: return Vector2(0.416,0.489)
		6: return Vector2(0.614,0.448)
		
	return Vector2.ZERO

func get_Circle_Offset2(index) -> Vector2:
	match index:
		0: return Vector2(0,0)
		1: return Vector2(0.088,0.279)
		2: return Vector2(0.194,0.491)
		3: return Vector2(0.644,0.391)
		4: return Vector2(0.457,0.441)
		5: return Vector2(0.267,0.491)
		6: 
			gamefinished = true
			return Vector2(0.833,0.375)
	return Vector2.ZERO
