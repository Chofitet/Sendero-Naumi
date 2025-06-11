extends VBoxContainer
@export var secondOnOneScreen : float
var screenSize
var childNum
signal ScrollEnds
signal PreScrollEnds
var minigamesResource : MiniGameResource

func _ready():
	screenSize = get_viewport_rect().size
	childNum = get_child_count(false)
	var newSizeScreen = Vector2(screenSize.x, screenSize.y * childNum)
	set_size(newSizeScreen)
	visible = false
	
	

func StartScroll():
	visible = true
	var PositionToTween = -1 * Vector2(0,(childNum - 1) * screenSize.y)
	await  get_tree().create_timer(2).timeout
	var tween : Tween = get_tree().create_tween()
	tween.tween_property(self,"position",PositionToTween, secondOnOneScreen * childNum)
	await tween.finished
	PreScrollEnds.emit()
	await  get_tree().create_timer(2).timeout
	SetCreditPass()
	ScrollEnds.emit()

func SetCreditPass():
	minigamesResource = ResourceLoader.load("user://MiniGameResource.tres")
	minigamesResource.StateMinigames["PassCredits"] = true
	ResourceSaver.save(minigamesResource, "user://MiniGameResource.tres")
