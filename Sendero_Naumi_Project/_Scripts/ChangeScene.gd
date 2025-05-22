extends Button 

@export var NextScene : String
@export var doPreloadScene : bool
@export var doChangeSceneInstantly : bool
@export var PreLoadInBeggining : bool
@export var fade_time : float
@export var texture = "fade"
@export var smoothness : float
@export var is_inverted : bool
@export var color : Color
@export var progressBar : ProgressBar
var preloadScene = ""
signal SceneLoaded

var Fade_in
var Fade_out
var General_Option
var delay = 0

func _ready():
	Fade_in = SceneManager.create_options(fade_time, texture, smoothness, is_inverted)
	Fade_out = SceneManager.create_options(fade_time, texture, smoothness, is_inverted)
	General_Option = SceneManager.create_general_options(color, 0, true, true)
	
	if doPreloadScene: preloadScene = NextScene
	if PreLoadInBeggining: PreloadScene()
	if !pressed.is_connected(_on_pressed):
		pressed.connect(_on_pressed)
	
func _on_pressed():
	await get_tree().create_timer(delay).timeout
	SoundManager.remove_all_sounds()
	SceneManager.change_scene(NextScene, Fade_in , Fade_out, General_Option, preloadScene)
	

func PreloadScene():
	if progressBar != null: 
		progressBar.visible = true
		startChargeBar()
	SceneManager.PreloadScene(NextScene)

func SetVisibility(x):
	visible = x

func StandarChangeScene():
	SoundManager.remove_all_sounds()
	get_tree().change_scene_to_file("res://Scenes/" + NextScene + ".tscn")

var once
func _process(delta):
	
	var progress = []
	ResourceLoader.load_threaded_get_status("res://Scenes/" + NextScene + ".tscn",progress)
	var statusProgress = ResourceLoader.load_threaded_get_status("res://Scenes/" + NextScene + ".tscn")
	print(progress[0])
	if progressBar != null and firstBarCharge:
		if progress[0] > 0.85:
			ChargeBar(progress[0], statusProgress)
		
		return
	
	if statusProgress == 3:
		
		if !once:
			SceneLoaded.emit()
		once = true
		if doChangeSceneInstantly: _on_pressed()

var firstBarCharge = false

func ChargeBar(progress, statusProgress):
	progressBar.value = progress  * 100
	
	if statusProgress == 3:
		if !once: LastChargeAfterProgressBar()
		

func LastChargeAfterProgressBar():
	once = true
	var tween = get_tree().create_tween()
	tween.tween_property(progressBar,"value",100,0.1).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
	
	SceneLoaded.emit()
	
	_on_pressed()

func startChargeBar():
	var tween = get_tree().create_tween()
	tween.tween_property(progressBar,"value",85,0.3).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
	firstBarCharge = true
