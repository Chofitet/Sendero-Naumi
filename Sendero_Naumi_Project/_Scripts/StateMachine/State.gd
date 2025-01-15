extends Node
class_name State
var save_file_path = "user://"
var save_file_name = "MiniGameResource.tres"
var minigameResourseFile = MiniGameResource.new()
var Zoneresource = ZoneResource.new()
var ActualState

signal inZone
signal backZone
signal Transitioned

func _ready():
	load_file()
	if minigameResourseFile.StateMinigames["ToLevelNaumi"]:
		get_tree().change_scene_to_file("res://Scenes/zone_complete_event.tscn")

func load_file():
	minigameResourseFile  = ResourceLoader.load(save_file_path  + save_file_name)

func save():
	ResourceSaver.save(minigameResourseFile,save_file_path+save_file_name)

#Setea la bool is_Complete en true para una zona cuando todos sus minijuegos fueron completados
func CheckAllTrue(Minigames):
	load_file()
	Zoneresource = ResourceLoader.load(save_file_path + "ZoneResource.tres")
	if Zoneresource.StateZones[self.name]: return
	var i = 0
	var once = true
	for m in Minigames:
		if (minigameResourseFile.StateMinigames[get_node(m).name]) == false: 
			return
		else: i += 1
		
		if(i == len(Minigames)):
			if !Zoneresource.StateZones[self.name]: once = false
			Zoneresource.StateZones[self.name] = true
			ResourceSaver.save(Zoneresource,save_file_path + "ZoneResource.tres")
			if !once: 
				minigameResourseFile.Set_State_Minigame("ToLevelNaumi")
				minigameResourseFile.Set_State_Minigame("ToUnlockIlands")
				save()
				get_tree().change_scene_to_file("res://Scenes/zone_complete_event.tscn")

#Reinicia todos las Zonas y Minijuegos
func RestartAll():
	
	
	if FileAccess.file_exists(save_file_path + "ZoneResource.tres"):
		DirAccess.remove_absolute(save_file_path + "ZoneResource.tres")
	if FileAccess.file_exists(save_file_path + "MiniGameResource.tres"):
		DirAccess.remove_absolute(save_file_path + "MiniGameResource.tres")
	if FileAccess.file_exists(save_file_path + "InstanceResource.tres"):
		DirAccess.remove_absolute(save_file_path + "InstanceResource.tres")
	
	await get_tree().create_timer(0.2).timeout
	
	var minigameResourceFile = MiniGameResource.new()
	var zoneResourceFile = ZoneResource.new()
	var instanceResource = InstanceResource.new()
	
	ResourceSaver.save(zoneResourceFile,save_file_path + "ZoneResource.tres")
	ResourceSaver.save(minigameResourceFile, save_file_path + "MiniGameResource.tres")
	ResourceSaver.save(instanceResource, save_file_path + "InstanceResource.tres")
	
	minigameResourceFile.Set_State_Minigame("noFirstTimePlay")
	
	get_tree().reload_current_scene()

func ChangeButtonBackVisibility(x, button):
	if (button == null): return
	button.visible = x


func Enter():
	pass

func Exit():
	pass

func Update(_detla : float):
	pass

func Physics_Update(_detla : float):
	pass
