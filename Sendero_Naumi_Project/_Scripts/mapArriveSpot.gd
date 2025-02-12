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
	squiggling.ActiveSquiggling()
	btn.visible = true
	handUI.SetVisibility(true)
	

func TakeMap():
	squiggling.InactiveSquiggling()
	handUI.SetVisibility(false)
	animMap.play("agarrado")
	await animMap.animation_finished
	animMap.visible = false
	animMapBig.play("map_enter")
