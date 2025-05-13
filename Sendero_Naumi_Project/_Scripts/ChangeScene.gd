extends Button 

@export var NextScene : String
@export var fade_time : float
@export var texture = "fade"
@export var smoothness : float
@export var is_inverted : bool
@export var color : Color
@export var isTransparent : bool = false

var Fade_in
var Fade_out
var General_Option
var delay = 0

func _ready():
	Fade_in = SceneManager.create_options(fade_time, texture, smoothness, is_inverted)
	Fade_out = SceneManager.create_options(fade_time, texture, smoothness, is_inverted)
	General_Option = SceneManager.create_general_options(color, 0, true, true)
	
	if !pressed.is_connected(_on_pressed):
		pressed.connect(_on_pressed)
	
func _on_pressed():
	await get_tree().create_timer(delay).timeout
	SoundManager.remove_all_sounds()
	SceneManager.change_scene(NextScene, Fade_in , Fade_out, General_Option )
	

func SetVisibility(x):
	visible = x

func StandarChangeScene():
	SoundManager.remove_all_sounds()
	get_tree().change_scene_to_file("res://Scenes/" + NextScene + ".tscn")
