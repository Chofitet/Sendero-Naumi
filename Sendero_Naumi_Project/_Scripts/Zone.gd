extends TextureRect

@export var timeToStartAnim : float

var save_file_path = "user://"
var save_file_name = "ZoneResource.tres"
var minigame_file_name = "MiniGameResource.tres"
var MinigameResourseFile = MiniGameResource.new()
var ZoneResourseFile = ZoneResource.new()
@export var ZonesForTriggerUnlock: Array[String] = []
var AreUnlocked: bool
signal ZoneComplete

func load_file():
		ZoneResourseFile  = ResourceLoader.load(save_file_path  + save_file_name)

func  _ready():
	load_file()
	SetAreUnlocked()
	Set_Complete()
	UnlockZone()
	StartFlotingAnim()

func Set_Complete():
	for z in ZoneResourseFile.StateZones.keys():
		if ZoneResourseFile.StateZones[self.name] == true:
			$TextureRect/check.visible = true
			ZoneComplete.emit()
			

func UnlockZone():
	
	if !AreUnlocked: return
	

	$TextureRect.visible = true


func SetAreUnlocked():
	AreUnlocked = ZoneResourseFile.StateZones["Unlocked" + self.name]
	

func MakeUnlockAnim():
	
	load_file()
	
	#Check if the conditions of unlocked are true 
	MinigameResourseFile = ResourceLoader.load(save_file_path  + minigame_file_name)
	if MinigameResourseFile.StateMinigames["ToUnlockIlands"] == false : return
	if AreUnlocked: return
	
	if ZonesForTriggerUnlock.size() == 0: return
	for z in ZonesForTriggerUnlock:

		if ZoneResourseFile.StateZones[z] == false:
			return
	
	$IslandAnimator.play("UnlolckIsland")
	
	ZoneResourseFile.Set_State_Zone("Unlocked" + self.name)
	
	ResourceSaver.save(ZoneResourseFile, save_file_path + save_file_name)
	
	SetAreUnlocked()

func StartFlotingAnim():
	await get_tree().create_timer(timeToStartAnim).timeout
	$MovingIsland.play("floating")
