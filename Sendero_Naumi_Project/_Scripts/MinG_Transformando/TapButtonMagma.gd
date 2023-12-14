extends Button
var NumOfTap = 3
signal Earthquake
signal BeforeEarthquake
signal SmallEarthquake
var timer 
var texturelava
var initTexture
var initScale 
var textureLavaChica
@export var lavaFace : Sprite2D
@export var nextLavaFace : Sprite2D

func _ready():
	initScale = lavaFace.get_parent().scale
	nextLavaFace.visible = false
	texturelava = load("res://Sprites/ZonaGeología/face 2.png")
	textureLavaChica = load("res://Sprites/ZonaGeología/face 2 chica.png")
	timer = get_node("Timer")
	timer.timeout.connect(EmitEarthquake)
	self.pressed.connect(Tap)
	initTexture = lavaFace.texture

func Tap():
	#NumOfTap -= 1
	#Input.vibrate_handheld(100)
	#if (NumOfTap != 0): SmallEarthquake.emit()
	if name == "TapButton1":
		lavaFace.texture = texturelava
	else:
		lavaFace.texture = textureLavaChica
	Input.vibrate_handheld(300)
	NumOfTap = 3
	visible = false
	timer.start()
	BeforeEarthquake.emit()

func EmitEarthquake():
	lavaFace.get_node("AnimationPlayer").play("lava_face_anim")
	Earthquake.emit()

func ChangeLavaFace():
	nextLavaFace.visible = true
	nextLavaFace.get_node("AnimationPlayer").play("RESET")
	nextLavaFace.get_node("AnimationPlayer").play("lava_face_anim_back")

func SetTrueVisibility():
	visible = true
