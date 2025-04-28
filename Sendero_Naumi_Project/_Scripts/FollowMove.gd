extends Node2D

@export var target : Node2D
var once

func _process(delta):
	if target != null : global_position = target.global_position

func OutAnim(x):
	if !x.is_in_group("topo"):return
	if once: return
	once = true
	$AnimationPlayer.play("out_Nube")
