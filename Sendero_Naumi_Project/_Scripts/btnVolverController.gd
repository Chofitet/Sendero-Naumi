extends CanvasLayer

@onready var btn = $Button
@onready var btnContinuar = $Menu/Panel/continuar
@onready var btnOutside = $Menu/outside
@onready var btnMapa = $Menu/Panel/VolverMapa
@onready var menu = $Menu
var ispause

func _ready():
	
	menu.visible = false
	btn.pressed.connect(AppearMenu)
	btnContinuar.pressed.connect(AppearMenu)
	btnOutside.pressed.connect(AppearMenu)
	btnMapa.pressed.connect(Mapa)

func AppearMenu():
	if !ispause:
		btn.visible = false
		menu.visible = true
		ispause = true
		get_tree().paused = true
	else: 
		btn.visible = true
		ispause = false
		menu.visible = false
		get_tree().paused = false

func Mapa():
	btnMapa.self_modulate = Color.GRAY
	get_tree().paused = false
