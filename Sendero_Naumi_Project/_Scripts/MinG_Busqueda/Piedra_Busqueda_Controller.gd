extends Control

@export var piedraTexture : Texture2D:
	set(new_value):
		piedraTexture = new_value

@onready var anim = $AnimController
@export var animBackground : AnimationPlayer
var piedra
var isnextAnim
var timerLoopLook
var isWinner
var isLose
var isFlip
var btnvolver
var animFlip = "Anim_rigth"
@export var backgroundpivot : Control
@export var particle1 : CPUParticles2D
@export var particle2 : CPUParticles2D
var background
@export var SetVisibility := []
var animationSprite

func _ready():
	$Piedra/Piedra.texture = piedraTexture
	timerLoopLook = get_node("LoopLookAnim")
	timerLoopLook.timeout.connect(LookAnim)
	timerLoopLook.wait_time=6
	timerLoopLook.start()
	#anim.animation_started.connect()
	piedra = get_node("Piedra/Piedra")
	anim.play("rock_look")
	background = get_node("BackgroundPivot/Background")
	if $Piedra/AnimPiedra1:
		animationSprite = $Piedra/AnimPiedra1
		anim.animation_started.connect(PlayAnimatedSprite)

func LookAnim():
	if !isnextAnim:
		anim.play("rock_look")
	if isLose:
		anim.play("rock_lose_3")

func NextAnim():
	anim.play("rock_idle")

func vuvuzelaAnim():
	if(isnextAnim):
		anim.play("anim_vuvuzela_up")

func JumpAnim():
	anim.play("rock_jump")

func SetNextAnimBool(Bool):
	PlayerVariables.EmitInactivePause()
	for v in SetVisibility:
		#get_node(v).visible = false
		pass
	isWinner = Bool
	isnextAnim = true
	anim.stop()
	anim.play("anim_vuvuzela_up")

func EndAnim():
	if isWinner:
		anim.play("rock_winner_1")
	else:
		anim.play("rock_lose_1")

func FlipAnim():
	if isFlip:
		scale.x = scale.x * -1
		piedra.scale.x = piedra.scale.x * -1
		animFlip = "Anim_left"
		if isWinner:
			backgroundpivot.get_node("TribunaLeft").visible = true
	else:
		if isWinner:
			backgroundpivot.get_node("TribunaRigth").scale.x = -1
		var tween = get_tree().create_tween()
		tween.tween_property(get_node("Piedra"),"scale",Vector2(0.8,0.8),0.7)

func SetScale(x):
	isFlip = x

func LoopWinn():
	particle1.visible = true
	particle2.visible = true
	particle1.emitting = true
	particle2.emitting = true
	anim.play("rock_winner_2")

func LoopLoseAnim():
	anim.play("rock_lose_2")
	isLose = true
	timerLoopLook.wait_time=3
	timerLoopLook.start()

func LoseCryAnim():
	PlayerVariables.EmitActivePause()
	anim.play("rock_lose_3")

func AnimBackground():
	animBackground.play(animFlip)
	

func StopFlipAnim():
	if !isWinner:
		EndAnim()

func MaskAnim():
	animBackground.play("Anim_mask")

func PlayAnimatedSprite(x):
	animationSprite.play(x)

func ResetRock():
	timerLoopLook.timeout.connect(LookAnim)
	timerLoopLook.wait_time=6
	timerLoopLook.start()
	if $Piedra/AnimPiedra1:
		animationSprite = $Piedra/AnimPiedra1
		anim.animation_started.connect(PlayAnimatedSprite)
	isWinner = false
	isLose = false
	isFlip = false
	isnextAnim = false
	anim.play("RESET")
	await  get_tree().create_timer(0.1).timeout
	anim.play("rock_look")
	
