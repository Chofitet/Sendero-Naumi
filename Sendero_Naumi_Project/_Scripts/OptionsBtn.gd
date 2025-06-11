extends Control

var minigameResourseFile = MiniGameResource.new()
var save_file_path = "user://"
var save_file_name = "MiniGameResource.tres"

@onready var volver = $Panel/VBoxContainer/volver
@onready var salir = $Panel/VBoxContainer/salir
@onready var ver_creditos = $Panel/VBoxContainer/verCreditos
@onready var reset_progreso = $Panel/VBoxContainer/ResetProgreso
@onready var button_change_scene_salir = $ButtonChangeSceneSalir
@onready var button_change_scene_credits = $ButtonChangeSceneCredits
@onready var button_change_scene_restart = $ButtonChangeSceneRestart
@onready var click_outside = $ClickOutside
var isMenuActivate = false
signal MenuOptionActive
signal MenuOptionDesactive

func _ready():
	CheckCredits()
	volver.pressed.connect(ActivateDesactivateMenu)
	click_outside.pressed.connect(ActivateDesactivateMenu)
	salir.pressed.connect(PressButton.bind(salir,button_change_scene_salir))
	ver_creditos.pressed.connect(PressButton.bind(ver_creditos,button_change_scene_credits))
	reset_progreso.pressed.connect(PressButton.bind(reset_progreso,button_change_scene_restart))


func ActivateDesactivateMenu():
	if !isMenuActivate:
		isMenuActivate = true
		visible = true
		MenuOptionActive.emit()
	else:
		isMenuActivate = false
		visible = false
		MenuOptionDesactive.emit()

func PressButton(btn, btnChange):
	btn.self_modulate = Color.LIGHT_GRAY
	btnChange._on_pressed()

func CheckCredits():
	load_file()
	if PlayerVariables.GetNaumiState() == 3: 
		ver_creditos.visible = true
		save()

func load_file():
	minigameResourseFile  = ResourceLoader.load(save_file_path+save_file_name)

func save():
	ResourceSaver.save(minigameResourseFile,save_file_path+save_file_name)
