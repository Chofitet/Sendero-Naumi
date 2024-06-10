extends Node2D

@export var isEvolving : bool
@onready var NaumiAnim = $naumiAnim
@onready var btn = $Button
@onready var Anim = $AnimationPlayer
var currentState = 0

var save_file_path = "user://"
var save_file_name = "MiniGameResource.tres"
var save_file_name_Zone = "ZoneResource.tres"
var minigameResourseFile = MiniGameResource.new()
var zoneResource = ZoneResource.new()

func load_file():
	zoneResource  = ResourceLoader.load(save_file_path  + save_file_name_Zone)

func save():
	ResourceSaver.save(minigameResourseFile,save_file_path+save_file_name)

func _ready():
	
	
	
	if isEvolving:
		SetNaumi(NaumiState() - 1)
		ToLevelUp()
	else:
		SetNaumi(NaumiState())
		btn.pressed.connect(Sleeping)

func ToLevelUp():
	await get_tree().create_timer(2).timeout
	$handUI.SetVisibility(true)
	NaumiAnim.play("call")
	btn.pressed.connect(Evolve)
	
func Evolve():
	btn.pressed.disconnect(Evolve)
	$handUI.SetVisibility(false)
	NaumiAnim.play("evolve")
	await NaumiAnim.animation_finished
	btn.pressed.connect(Sleeping)
	PlayerVariables.SetNaumiEvolve()
	SetNaumi(NaumiState())
	NaumiAnim.play("sleeping")
	$CanvasLayer/ButtonChangeScene.visible = true

func Sleeping():
	btn.visible = false
	NaumiAnim.play("tapped")
	Anim.play("tap_naumi")
	await Anim.animation_finished
	NaumiAnim.play("sleeping")
	btn.visible = true

func SetNaumi(num):
	match num:
		0:
			NaumiAnim.sprite_frames = preload("res://Resources/NaumiSpriteFrames/N0.tres")
		1:
			NaumiAnim.sprite_frames = preload("res://Resources/NaumiSpriteFrames/N1.tres")
		2:
			NaumiAnim.sprite_frames = preload("res://Resources/NaumiSpriteFrames/N2.tres")
		3:
			NaumiAnim.sprite_frames = preload("res://Resources/NaumiSpriteFrames/N3.tres")

func NaumiState() -> int:
	var num = 0
	load_file()
	for z in zoneResource.StateZones.keys():
		if zoneResource.StateZones[z]:
			num += 1
	return num
