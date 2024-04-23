extends ColorRect

@export var y : int
@export var hasSizeOffset : bool
var timer 
var initialpos

func _ready():
	get_parent().get_parent().get_parent().Transitioned.connect(AnimBack)
	initialpos = position

func Anim():
	$AnimationPlayer.play("close_overlay")
	await $AnimationPlayer.animation_finished
	get_parent().get_node("hinchada").visible = false

func AnimBack():
	get_parent().get_node("hinchada").visible = true
	$AnimationPlayer.play("RESET")
