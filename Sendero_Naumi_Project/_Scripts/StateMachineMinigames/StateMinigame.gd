extends Node
class_name StateMinigame

var path_save_data = "user://"
var file_save_data = "InstanceResource.tres"
var InstanceR = InstanceResource.new()
var ActualMinigame
signal Transitioned

func Enter():
	pass

func Exit():
	pass

func Update(_detla : float):
	pass

func Physics_Update(_detla : float):
	pass

func GetInstanceOfMinigame() -> int:
	load_file()
	return InstanceR.InstanceMinigames[get_parent().get_parent().name]

func IncruseInstanceOfMinigame():
	load_file()
	InstanceR.UpdateInstance(get_parent().get_parent().name)
	save()

func load_file():
	InstanceR = ResourceLoader.load(path_save_data + file_save_data)
func save():
	ResourceSaver.save(InstanceR, path_save_data + file_save_data)

func GetFixedIndex(array) -> int:
	var auxindex = GetInstanceOfMinigame() 
	while auxindex >= array.size():
		auxindex -= 1
	return auxindex

func SetActualMinigame(Nminigame):
	ActualMinigame = Nminigame

func SetVisibilityHUD(x):
	for c in get_children():
		if c is CanvasLayer:
			c.visible = x
