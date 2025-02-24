extends Control

@onready var animMap = $MapAnim
@onready var btn = $Button
@onready var handUI = $handUI
@onready var animMapBig = $Mapa/AnimationPlayer
@onready var squiggling = $SquigglingSprite

func _ready():
	btn.button_down.connect(TakeMap)

func playAnimMap():
	animMap.play("caida")
	await  animMap.animation_finished
	await  get_tree().create_timer(0.5).timeout
	$presenta/DotsAnim/AnimationPlayer.play("dot_wave")
	await  get_tree().create_timer(0.2).timeout
	squiggling.ActiveSquiggling()
	btn.visible = true
	handUI.SetVisibility(true)
	

func TakeMap():
	squiggling.InactiveSquiggling()
	handUI.SetVisibility(false)
	animMap.play("agarrado")
	await animMap.animation_finished
	animMapBig.play("map_enter")
	await  get_tree().create_timer(0.1).timeout
	animMap.visible = false
