extends Sprite2D

@onready var collShape = $Area2D/CollisionShape2D
@onready var button = $Button
@onready var area = $Area2D
@export var correctSpot : TextureRect
var LaserShader 
@export var colorShader : Color
@onready var squiggly = $SquigglingSprite
var isInArea
var line 
var posClick
var ClickInButton : bool = false
var isComplete : bool = false
var markComplete : bool = false
var onHold : bool = false
var OnRigthSpot
var laserSound
signal isLaserDrag

func _ready():
	var parent = get_parent()
	parent.AllTrue.connect(allTrue)
	button.button_down.connect(OnButton)
	area.area_entered.connect(OnArea)
	area.area_exited.connect(OutArea)
	for item in parent.get_children():
		item.isLaserDrag.connect(LaserAreDragging)
	
	line = $LaserRay
	LaserShader = line.material


func _input(event):
	if Input.is_action_pressed("TouchScreen"):
		posClick = event.position
		squiggly.InactiveSquiggling

	if Input.is_action_just_released("TouchScreen"):
		$unirSound.StopLoopSound()
		if !OnRigthSpot:$SquigglingSprite.ActiveSquiggling()
		if ClickInButton == false: return
		ClickInButton = false
		if isInArea != null:
			area.position = isInArea.global_position - area.get_parent().global_position
			line.set_point_position(1,isInArea.get_parent().get_node("unionSpot").global_position - line.global_position)
			get_parent().CheckTrue()
			if isInArea == correctSpot.get_node("Area2D"):
				area.area_exited.disconnect(OutArea)
				isInArea.get_parent().Disconnect()
				ReaplaceShaderComplete()
				OnRigthSpot = true
				$SquigglingSprite.InactiveSquiggling()
				if markComplete : 
					isComplete = true
					get_parent().CheckTrue()
				return
			
			ReplaceShaderWrong()
			return
		posClick = Vector2.ZERO
		area.position = Vector2.ZERO
		line.set_point_position(1,posClick)


func allTrue():
	await get_tree().create_timer(2).timeout
	$Panel.visible = false 
	await get_tree().create_timer(2).timeout
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",Vector2(position.x-44,position.y),0.3)
	var tween2 = get_tree().create_tween()
	tween2.tween_property(self,"scale",scale /1.1,0.3)

func ReaplaceShaderComplete():
	var style:StyleBoxFlat = StyleBoxFlat.new()
	style.bg_color =  colorShader
	style.corner_detail = 8
	style.corner_radius_top_left =16
	style.corner_radius_top_right =16
	style.corner_radius_bottom_left =16
	style.corner_radius_bottom_right =16
	$Panel.add_theme_stylebox_override("panel", style)
	
	var shaderline = line.material.duplicate()
	line.material = shaderline
	var anim : AnimationPlayer = $AnimationPlayer 
	anim.play("Laser_Complete")
	var tween = get_tree().create_tween()
	tween.tween_method(set_shader_value, line.material.get_shader_parameter("color1"), colorShader, 2.3)

func ReplaceShaderWrong():
	SoundManager.play("unir","incorrecto")
	var anim : AnimationPlayer = $AnimationPlayer 
	anim.play("laser_incorrecto")
#	var initialColor = line.material.get_shader_parameter("color1")
#	var initialColorMix = line.material.get_shader_parameter("colorMixFactor")
#	var initialGlow = line.material.get_shader_parameter("glowFactor")
#	var shaderline = line.material.duplicate()
#	line.material = shaderline
#	button.visible = false
#	var tween = get_tree().create_tween()
#	tween.tween_method(set_shader_value, initialColor, Color(1,0,0,1), 1)
#	var tween2 = get_tree().create_tween()
#	tween2.tween_method(set_shader_glow, line.material.get_shader_parameter("glowFactor"), 1, 1)
#	line.material.set_shader_parameter("colorMixFactor",0)
#	await tween2.finished
#	line.material.set_shader_parameter("colorMixFactor",initialColorMix)
#	line.material.set_shader_parameter("color1",initialColor)
#	line.material.set_shader_parameter("glowFactor",initialGlow)
	await anim.animation_finished
	button.visible = true
	anim.play("RESET")
	resetAll()

func set_shader_value(value):
	line.material.set_shader_parameter("color1", value);
	
func set_shader_glow(glow):
	line.material.set_shader_parameter("glowFactor", glow)
	
func OnButton():
	$unirSound.PlayLoopEvent("laserLoop")
	ClickInButton = true
	isInArea = null
	isLaserDrag.emit()

func LaserAreDragging():
	$SquigglingSprite.InactiveSquiggling()
	
func _process(delta):
	if OnRigthSpot:
		var _position = correctSpot.get_node("unionSpot")
		line.set_point_position(1,_position.global_position - line.global_position)
	if ClickInButton:
		line.set_point_position(1,posClick - line.global_position)
		area.global_position= posClick

func OnArea(x):
	if !x.is_in_group("Spot"): return
	isInArea = x 
	print("enter")
	if x == correctSpot.get_node("Area2D"):
		CorrectArea()
	
func OutArea(x):
	isInArea = null
	markComplete = false
	print("exit")
	button.button_down.connect(OnButton)

func resetAll():
	isInArea = null
	markComplete = false
	posClick = Vector2.ZERO
	area.position = Vector2.ZERO
	line.set_point_position(1,posClick)

func CorrectArea():
	markComplete = true
	button.button_down.disconnect(OnButton)
	
	

