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
var call_timer 
signal ButtonPress
signal ToContinue
var  isIdleOncePlayed
@onready var GeneralsoundTrigger = $GeneralNaumiSounds
var soundAnim 
@onready var ActualNaumiSounds = $NaumiSounds0
var delayNaumiEvolveSound = 0
var NaumiComplete = false
@export var PanelNaumi0 : Panel
@export var PanelNaumiEvolve : Panel
@export var PanelNaumiFinal : Panel


func load_file():
	zoneResource  = ResourceLoader.load(save_file_path  + save_file_name_Zone)

func save():
	ResourceSaver.save(minigameResourseFile,save_file_path+save_file_name)

func _ready():
	tree_exited.connect(realeCallTimer)
	if has_node("CallTimer"):
		call_timer = $CallTimer
	if has_node("soundsCallAnimation"):
		soundAnim = $soundsCallAnimation
	if IntroNaumi:
		btn.pressed.connect(Sleeping)
		return
	#timer.timeout.connect(PlayRandomIdleAnim)
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

func realeCallTimer():
	if call_timer: call_timer.stop()

func ToLevelUp():
	$pivot/Parts/partsAnimator.play("RESET")
	#await get_tree().create_timer(2).timeout
	$pivot/Parts.visible = false
	$pivot/handUI.SetTimerTime(6)
	$pivot/handUI.SetVisibility(true)
	NaumiAnim.play("call")
	if soundAnim :soundAnim.play("Naumi" + str(NaumiState()))
	if call_timer: call_timer.start()
	extraAnim = ""
	if call_timer: call_timer.timeout.connect(ReapetCall)
	btn.pressed.connect(Evolve)

var extraAnim = ""
func ReapetCall():
	if NaumiState() == 0 or NaumiState() == 1:
		if extraAnim != "":
			extraAnim = ""
		else:
			extraAnim = ".1"
	NaumiAnim.play("call" + extraAnim)
	if soundAnim: soundAnim.play("Naumi" + str(NaumiState()) + extraAnim)
	var range = randf_range(1.5,2.7)
	if call_timer: call_timer.wait_time =  range
	pass


func Evolve():
	if soundAnim: soundAnim.stop()
	if call_timer:
		call_timer.timeout.disconnect(ReapetCall)
		call_timer.stop()
	btn.pressed.disconnect(Evolve)
	ActualNaumiSounds.PlayEvent("rompe",delayNaumiEvolveSound)
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
	#timer.timeout.disconnect(PlayRandomIdleAnim)
	$pivot/Parts/partsAnimator.play("tap")
	if !IntroNaumi : ActualNaumiSounds.StopSoundsInCuttableQueue()
	GeneralsoundTrigger.StopSoundsInCuttableQueue()
	GeneralsoundTrigger.PlayEvent("tap",0,true)
	#$pivot/Parts/eye.play("tap")
	#$pivot/Parts/ear.play("tap")
	#$pivot/Parts/wing.play("tap")
	Anim.play("tap_naumi")
	await Anim.animation_finished
	ShowPanel()
	$pivot/Parts/zzz.play("tap")
	$pivot/Parts/partsAnimator.play("idle")
	if NaumiState() > 0: GeneralsoundTrigger.PlayEvent("zzz",0,true)
	NaumiAnim.play("sleeping")
	btn.visible = true
	
#	if !isIdleOncePlayed:
#		timer.start()
#		timer.timeout.connect(PlayRandomIdleAnim)

func SetNaumi(num):
	match num:
		0:
			NaumiAnim.sprite_frames = load("res://Resources/NaumiSpriteFrames/N0.tres")
		1:
			delayNaumiEvolveSound = 1
			debris[0].visible = true
			NaumiAnim.sprite_frames = load("res://Resources/NaumiSpriteFrames/N1.tres")
		2:
			delayNaumiEvolveSound = 1.2
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
			await get_tree().create_timer(0.1).timeout
			minigameResourseFile = ResourceLoader.load(save_file_path+save_file_name)
			if minigameResourseFile.StateMinigames["PassCredits"] : 
				ToContinue.emit()
				minigameResourseFile.StateMinigames["PassCredits"] = false
				NaumiComplete = true
				save()
	
	if num + 1 > 3 : return
	var naumiToGet = "NaumiSounds" + str(num + 1)
	ActualNaumiSounds = get_node(naumiToGet)
	pass

func NaumiState() -> int:
	var num = 0
	if PlayerVariables.DebugMode : return PlayerVariables.NaumiDebugNum
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

signal buttonPressedOnce
var once

func ButtonPressedOnce():
	if !once: buttonPressedOnce.emit()
	once = true

func ShowPanel():
	if IntroNaumi: return
	if NaumiComplete:
		if PanelNaumiFinal.isOn: return
		PanelNaumiFinal.EnterPanel()
		return
	if NaumiState() == 0:
		if PanelNaumi0.isOn: return
		PanelNaumi0.EnterPanel()
	else:
		if PanelNaumiEvolve.isOn: return
		PanelNaumiEvolve.EnterPanel()
	
