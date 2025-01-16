extends Control

var save_file_path = "user://"
var save_file_name = "MiniGameResource.tres"

func ResetAll():
	
	var minigameResourceFile = MiniGameResource.new()
	var zoneResourceFile = ZoneResource.new()
	var instanceResource = InstanceResource.new()

	# Sobrescribir (o crear) los archivos con los nuevos recursos
	if ResourceSaver.save(zoneResourceFile, save_file_path + "ZoneResource.tres") != OK:
		push_error("Error al guardar ZoneResource")
	if ResourceSaver.save(minigameResourceFile, save_file_path + "MiniGameResource.tres") != OK:
		push_error("Error al guardar MiniGameResource")
	if ResourceSaver.save(instanceResource, save_file_path + "InstanceResource.tres") != OK:
		push_error("Error al guardar InstanceResource")

	# Configurar el estado inicial del recurso de minijuegos
	minigameResourceFile.Set_State_Minigame("noFirstTimePlay")

	get_tree().change_scene_to_file("res://Scenes/Map_Screen.tscn")
	

func BackToMap():
	get_tree().change_scene_to_file("res://Scenes/Map_Screen.tscn")
