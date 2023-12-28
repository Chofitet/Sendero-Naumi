extends Sprite2D

var NaumiStates = [load("res://Sprites/Naumi/N0 a N1.png"),
load("res://Sprites/Naumi/Naumi_1.png"),
load("res://Sprites/Naumi/Naumi_02.png")]
var currentState = 0

var save_file_path = "user://"
var save_file_name = "MiniGameResource.tres"
var save_file_name_Zone = "ZoneResource.tres"
var minigameResourseFile = MiniGameResource.new()
var zoneResource = ZoneResource.new()

var anim
var button

func load_file():
	zoneResource  = ResourceLoader.load(save_file_path  + save_file_name_Zone)

func save():
	ResourceSaver.save(minigameResourseFile,save_file_path+save_file_name)

func _ready():
	button = get_node("Button")
	button.pressed.connect(_on_button_pressed)
	anim = get_node("AnimationPlayer")
	load_file()
	for z in zoneResource.StateZones.keys():
		if zoneResource.StateZones[z]:
			currentState += 1
	texture = NaumiStates[currentState - 1]
	get_node("ButtonChangeContinue").visible = false

func _on_button_pressed():
	minigameResourseFile = ResourceLoader.load(save_file_path + save_file_name)
	minigameResourseFile.StateMinigames["ToLevelNaumi"] = false
	save()
	get_node("AnimationPlayer").stop()
	anim.play("tap_anim")
	button.visible = false

func inEndAnim():
	get_node("ButtonChangeContinue").visible = true

func NextAnimAfterTap():
	anim.play("N0-N1_evo")
