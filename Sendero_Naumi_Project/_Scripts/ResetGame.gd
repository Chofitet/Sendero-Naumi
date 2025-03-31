extends Control

var save_file_path = "user://"
var save_file_name = "MiniGameResource.tres"

func ResetAll():
	
	var minigameResourceFile = MiniGameResource.new()
	var zoneResourceFile = ZoneResource.new()
	var instanceResource = InstanceResource.new()
	
	minigameResourceFile.take_over_path(save_file_path + "MiniGameResource.tres")
	zoneResourceFile.take_over_path(save_file_path + "ZoneResource.tres")
	instanceResource.take_over_path(save_file_path + "InstanceResource.tres")
#	minigameResourceFile = ResourceLoader.load(save_file_path + "MiniGameResource.tres")
#	zoneResourceFile = ResourceLoader.load(save_file_path + "ZoneResource.tres")
#	instanceResource =  ResourceLoader.load(save_file_path + "InstanceResource.tres")
	
	minigameResourceFile.Set_State_Minigame("MarkAsPlayed")
	# Sobrescribir (o crear) los archivos con los nuevos recursos
	if ResourceSaver.save(zoneResourceFile, save_file_path + "ZoneResource.tres") != OK:
		push_error("Error al guardar ZoneResource")
	if ResourceSaver.save(minigameResourceFile, save_file_path + "MiniGameResource.tres") != OK:
		push_error("Error al guardar MiniGameResource")
	if ResourceSaver.save(instanceResource, save_file_path + "InstanceResource.tres") != OK:
		push_error("Error al guardar InstanceResource")


