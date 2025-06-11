extends Timer

var Fade_in
var Fade_out
var General_Option

@export var isAutomatic : bool

@export var NextScene : String
@export var fade_time : float
@export var texture = "fade"
@export var smoothness : float
@export var is_inverted : bool
@export var color : Color

func _ready():
	timeout.connect(_on_timeout)
	Fade_in = SceneManager.create_options(fade_time, texture, smoothness, is_inverted)
	Fade_out = SceneManager.create_options(fade_time, texture, smoothness, is_inverted)
	General_Option = SceneManager.create_general_options(color, 0, true, true)

func StartTimer():
	start()

func _on_timeout():
	SceneManager.change_scene(NextScene, Fade_in , Fade_out, General_Option )



func _on_tree_entered():
	if isAutomatic :
		StartTimer()


func _on_draggeable_system_is_correct():
	StartTimer()

func QuitApplication():
	get_tree().quit()
