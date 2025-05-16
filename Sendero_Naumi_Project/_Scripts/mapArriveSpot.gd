extends Control

@onready var animMap = $MapAnim
@onready var btn = $Button
@onready var handUI = $handUI
@onready var animMapBig = $Mapa/AnimationPlayer
@onready var squiggling = $SquigglingSprite

func _ready():
	btn.button_down.connect(TakeMap)

func playAnimMap():
	animMap.visible = true
	animMap.play("caida")
	await  animMap.animation_finished
	await  get_tree().create_timer(0.7).timeout
	squiggling.ActiveSquiggling()
	$SoundMapLoop.PlayLoopEvent("vientoLoop")
	btn.visible = true
	await  get_tree().create_timer(1).timeout
	handUI.SetVisibility(true)
	$presenta/DotsAnim/AnimationPlayer.play("dot_wave")
	

func TakeMap():
	squiggling.InactiveSquiggling()
	handUI.SetVisibility(false)
	animMap.play("agarrado")
	btn.visible = false
	await animMap.animation_finished
	animMapBig.play("map_enter")
	await  get_tree().create_timer(0.1).timeout
	animMap.visible = false
	await  get_tree().create_timer(2.3).timeout
	$SoundMapLoop.StopLoopSound()
