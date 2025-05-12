extends CanvasLayer

@onready var btn = $GenericButton
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
	PlayerVariables.InactivePause.connect(InactiveButton)
	PlayerVariables.ActivePause.connect(ActiveButton)

func AppearMenu():
	if !ispause:
		btn.visible = false
		menu.visible = true
		ispause = true
		SoundManager.pause_Sound(true)
		btn.ExitAnim()
		get_tree().paused = true
	else: 
		#btn.visible = true
		ispause = false
		menu.visible = false
		btn.EnterAnim()
		SoundManager.pause_Sound(false)
		get_tree().paused = false

func Mapa():
	btnMapa.self_modulate = Color.GRAY
	SoundManager.remove_all_sounds()
	await get_tree().create_timer(0.6).timeout
	SoundManager.remove_all_sounds()
	get_tree().paused = false

func InactiveButton():
	btn.ExitAnim(true)

func ActiveButton():
	btn.EnterAnim()
