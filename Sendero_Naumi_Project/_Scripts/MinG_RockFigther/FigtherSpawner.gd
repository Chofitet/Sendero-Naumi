extends Control
@export var LeftTexture : Texture
@export var LeftName : String
@export var RigthTexture : Texture
@export var RigthName : String
@export var LeftBtn : Control
@export var RigthBtn : Control
@export var isLeftWinner : bool
@export var stateMachine : Node
@export var AnimatorUI : AnimationPlayer
@export var Overlay1 : ColorRect
@export var Overlay2 : ColorRect
@export var PiedraScale : Vector2 = Vector2(0.639,0.369)
@export var PiedraOffset : Vector2 = Vector2.ZERO
@export var RetryPanel : Panel 
var LeftRock
var RigthRock
var instance = preload("res://Scenes/Zona_Geología/piedra_luchador.tscn")
var playerWinner 
signal PlayerLost
signal fight

func _ready():
	get_parent().InstanceTrue.connect(SpawnFighters.bind(true))
	RigthBtn.get_child(1).pressed.connect(Figth.bind(false))
	LeftBtn.get_child(1).pressed.connect(Figth.bind(true))

func SpawnFighters(playEnterAnim):
	PlayerVariables.EmitActivePause()
	LeftRock = instance.instantiate()
	RigthRock = instance.instantiate()
	add_child(LeftRock)
	LeftRock.position.x = 0
	LeftRock.init(LeftTexture,-1,LeftBtn.get_child(1),isLeftWinner,RigthRock,playEnterAnim)
	LeftBtn.get_child(0).get_child(0).text = LeftName
	await  get_tree().create_timer(1.1).timeout
	add_child(RigthRock)
	RigthRock.position.x = 0
	RigthRock.init(RigthTexture,1,RigthBtn.get_child(1),!isLeftWinner,LeftRock,playEnterAnim,PiedraScale,PiedraOffset)
	RigthBtn.get_child(0).get_child(0).text = RigthName

func PassInstance():
	if !playerWinner:
		PlayerVariables.EmitActivePause()
		RetryPanel.EnterPanel()
		SoundManager.play("level", "ups")
		return
	
	stateMachine.Trigger_On_Child_Transition("Moraleja")
	await get_tree().create_timer(0.6).timeout
	LeftRock.queue_free()
	RigthRock.queue_free()
	SoundManager.play("level", "correct")

func Figth(btnLeftPressed):
	if LeftRock == null: return
	PlayerVariables.EmitInactivePause()
	SoundManager.play("level","eleccion")
	if btnLeftPressed == isLeftWinner: playerWinner = true
	else: playerWinner = false
	Overlay1.Anim()
	Overlay2.Anim()
	AnimatorUI.play_backwards("EnterAnim")
	await get_tree().create_timer(4.1).timeout
	SoundManager.play("level","explosion")
	

func RetryLevel():
	if LeftRock == null : return
	stateMachine.Trigger_On_Child_Transition("Juego", true)
	await get_tree().create_timer(0.4).timeout
	LeftRock.queue_free()
	RigthRock.queue_free()
	
