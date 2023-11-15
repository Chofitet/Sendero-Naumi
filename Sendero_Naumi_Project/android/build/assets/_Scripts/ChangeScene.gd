extends Button 

@export var NextScene : String
@export var fade_time : float
@export var texture = "fade"
@export var smoothness : float
@export var is_inverted : bool
@export var color : Color

var Fade_in
var Fade_out
var General_Option

func _ready():
	Fade_in = SceneManager.create_options(fade_time, texture, smoothness, is_inverted)
	Fade_out = SceneManager.create_options(fade_time, texture, smoothness, is_inverted)
	General_Option = SceneManager.create_general_options(color, 0, true, true)

func _on_pressed():
	SceneManager.change_scene(NextScene, Fade_in , Fade_out, General_Option )

