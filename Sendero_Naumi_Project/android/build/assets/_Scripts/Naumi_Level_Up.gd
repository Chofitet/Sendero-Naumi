extends Sprite2D

var NaumiStates = [load("res://Sprites/Naumi/Naumi_0.png"),
load("res://Sprites/Naumi/Naumi_1.png"),
load("res://Sprites/Naumi/Naumi_02.png")]
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
	load_file()
	for z in zoneResource.StateZones.keys():
		if zoneResource.StateZones[z]:
			currentState += 1
	position = get_viewport_rect().size/2
	texture = NaumiStates[currentState - 1]
	get_node("ButtonChangeContinue").visible = false
	get_node("AnimationPlayer").play("to_level_up")

func _on_button_pressed():
	PlayerVariables.lastState = "ZoneCompleteEvent"
	get_node("ButtonChangeContinue").visible = true
	texture = NaumiStates[currentState]
	minigameResourseFile.StateMinigames["ToLevelNaumi"] = false
	save()
	get_node("AnimationPlayer").stop()

