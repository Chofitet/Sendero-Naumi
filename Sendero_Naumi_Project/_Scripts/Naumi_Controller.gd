extends Node2D

@export var isEvolving : bool
@export var IntroNaumi : bool
@onready var NaumiAnim = $pivot/naumiAnim
@onready var btn = $pivot/Button
@onready var Anim = $pivot/AnimationPlayer
var currentState = 0
var debris =[]
var parts =["eye","ear","wing"] 
var save_file_path = "user://"
var save_file_name = "MiniGameResource.tres"
var save_file_name_Zone = "ZoneResource.tres"
var minigameResourseFile = MiniGameResource.new()
var zoneResource = ZoneResource.new()
@onready var timer = $Timer
signal ButtonPress
var  isIdleOncePlayed

func load_file():
	zoneResource  = ResourceLoader.load(save_file_path  + save_file_name_Zone)

func save():
	ResourceSaver.save(minigameResourseFile,save_file_path+save_file_name)

func _ready():
	if IntroNaumi:
		btn.pressed.connect(Sleeping)
		return
	timer.timeout.connect(PlayRandomIdleAnim)
	for d in $Debris.get_children():
		debris.append(d)
		d.visible = false
	
	if isEvolving:
		SetNaumi(NaumiState() - 1)
		ToLevelUp()
	else:
		SetNaumi(NaumiState())
		btn.pressed.connect(Sleeping)
		
	timer.wait_time = randf_range(6,13)

func ToLevelUp():
	$pivot/Parts/partsAnimator.play("RESET")
	#await get_tree().create_timer(2).timeout
	$pivot/Parts.visible = false
	$pivot/handUI.SetVisibility(true)
	NaumiAnim.play("call")
	btn.pressed.connect(Evolve)
	
func Evolve():
	btn.pressed.disconnect(Evolve)
	$pivot/handUI.SetVisibility(false)
	NaumiAnim.play("evolve")
	await NaumiAnim.animation_finished
	$pivot/Parts.visible = true
	btn.pressed.connect(Sleeping)
	PlayerVariables.SetNaumiEvolve()
	SetNaumi(NaumiState())
	NaumiAnim.play("sleeping")
	$pivot/CanvasLayer/ButtonChangeScene.EnterAnim()
	$pivot/Parts/partsAnimator.play("idle")

func Sleeping():
	btn.visible = false
	$pivot/Parts/zzz.stop()
	NaumiAnim.play("tapped")
	timer.timeout.disconnect(PlayRandomIdleAnim)
	$pivot/Parts/partsAnimator.play("tap")
	#$pivot/Parts/eye.play("tap")
	#$pivot/Parts/ear.play("tap")
	#$pivot/Parts/wing.play("tap")
	Anim.play("tap_naumi")
	await Anim.animation_finished
	$pivot/Parts/zzz.play("tap")
	$pivot/Parts/partsAnimator.play("idle")
	NaumiAnim.play("sleeping")
	btn.visible = true
	
	if !isIdleOncePlayed:
		timer.start()
		timer.timeout.connect(PlayRandomIdleAnim)

func SetNaumi(num):
	match num:
		0:
			NaumiAnim.sprite_frames = load("res://Resources/NaumiSpriteFrames/N0.tres")
		1:
			debris[0].visible = true
			NaumiAnim.sprite_frames = load("res://Resources/NaumiSpriteFrames/N1.tres")
		2:
			debris[0].visible = true
			debris[1].visible = true
			NaumiAnim.sprite_frames = load("res://Resources/NaumiSpriteFrames/N2.tres")
			$pivot/Parts/ear.visible = true
		3:
			debris[0].visible = true
			debris[1].visible = true
			debris[2].visible = true
			NaumiAnim.sprite_frames = load("res://Resources/NaumiSpriteFrames/N3.tres")
			$pivot/Parts/ear.visible = true
			$pivot/Parts/wing.visible = true
			$pivot/CanvasLayer/Button.NextScene = "Credits"

func NaumiState() -> int:
	var num = 0
	load_file()
	for z in zoneResource.StateZones.keys():
		if zoneResource.StateZones[z]:
			if not "Unlocked" in z: num += 1
	return num
	
var available_indices = []

func PlayRandomIdleAnim():
	
	var anim = $pivot/Parts/eye
	anim.play("idle")
	
	await  anim.animation_finished
	
	$pivot/Parts/zzz.play("tap")
	isIdleOncePlayed = true
	
#	if available_indices.size() == 0:
#		for p in parts:
#			available_indices.append(p)
#
#	var random_index = available_indices[randi_range(0, available_indices.size() - 1)]
#
#	available_indices.erase(random_index)
#
#	var partsPath = "pivot/Parts/"
#	var path = partsPath + random_index
#	get_node(path).play("idle")
#	timer.wait_time = randf_range(5,13)

func ButtonPressed():
	ButtonPress.emit()
