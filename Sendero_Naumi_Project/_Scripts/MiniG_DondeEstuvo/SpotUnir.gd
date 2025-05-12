@tool
extends TextureRect
var lastEnter
signal mouse_released
signal PlanetsAling
var isexit
@export var colorShader : Color
@export var nombre: String:
	set(newValue):
		nombre = newValue
		$Panel/Label.text = nombre

@export var item : Sprite2D


func _ready():
	$Area2D.area_entered.connect(CheckUnion)
	$Area2D.area_exited.connect(Exit)

func _input(event):
	if Input.is_action_just_released("TouchScreen"):
		mouse_released.emit()
		if lastEnter != null and lastEnter.get_parent() == item:
			var style:StyleBoxFlat = StyleBoxFlat.new()
			style.bg_color =  colorShader
			style.corner_detail = 8
			style.corner_radius_top_left =16
			style.corner_radius_top_right =16
			style.corner_radius_bottom_left =16
			style.corner_radius_bottom_right =16
			$Panel.add_theme_stylebox_override("panel", style)

func CheckUnion(x):
	isexit = false
	if !x.is_in_group("item") : return
	if lastEnter == null:
		lastEnter = x
	elif lastEnter != null and x != lastEnter:
		await mouse_released
		if isexit: return
		lastEnter.get_parent().resetAll()
		lastEnter = x

func Exit(x):
	isexit = true
	if x == lastEnter:
		lastEnter = null

func Disconnect():
	$Area2D.queue_free()

func AnimToRigth():
	await get_tree().create_timer(1).timeout
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position", position + Vector2(500,0),1).set_ease(Tween.EASE_IN).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SPRING)
	await get_tree().create_timer(0.2).timeout
	SoundManager.play("instance2","planetasAfuera")

func AnimToAling():
	await get_tree().create_timer(3).timeout
	var tween = get_tree().create_tween()
	tween.tween_property(self,"global_position", Vector2(global_position.x,item.global_position.y - $unionSpot.position.y), 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SPRING)
	await get_tree().create_timer(0.4).timeout
	SoundManager.play("instance2","planetasUnidos")
	await tween.finished
	$unionSpot.position.x += 50 
	var tween2 = get_tree().create_tween()
	tween2.tween_property(self,"position", Vector2(position.x +40,position.y),0.3)
	PlanetsAling.emit()
	
