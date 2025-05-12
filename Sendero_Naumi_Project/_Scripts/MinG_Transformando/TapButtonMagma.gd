extends Button
var NumOfTap = 3
signal Earthquake
signal BeforeEarthquake
signal SmallEarthquake
@export var EarthquakeAnim : AnimationPlayer
var timer 
var texturelava
var initTexture
var initScale 
var textureLavaChica
@export var lavaFace : AnimatedSprite2D
@export var nextLavaFace : AnimatedSprite2D
@export var ParentRock : Node2D
@export var PartsToBreak : int
var NumOfPart = 0
var PartsOfPath := []
var NumOfTouch = 0


func _ready():
	#initScale = lavaFace.get_parent().scale
	#nextLavaFace.visible = false
	texturelava = load("res://Sprites/ZonaGeología/face 2.png")
	textureLavaChica = load("res://Sprites/ZonaGeología/face 2 chica.png")
	timer = get_node("Timer")
	timer.timeout.connect(EmitEarthquake)
	self.pressed.connect(Tap)
	#initTexture = lavaFace.texture
	for p in $resquebrajado.get_children():
		PartsOfPath.append(p)
		NumOfPart +=1

func Tap():
	if NumOfTouch != PartsToBreak:
		EarthquakeAnim.OnSmallEarthquake()
		ActiveDesquebrajado(NumOfTouch)
		NumOfTouch += 1
		HitLavaFace(0.6, "idle")
		#var StringTap = "terremoto" + str(tapBTN)
		SoundManager.play("earthquakes", "terremotoCorto")
		return
	NumOfTap = 3
	disabled = true
	timer.start()
	SoundManager.play("earthquakes", "explosion")
	HitLavaFace(1.5, "out")
	$Bloqueo.visible = false
	$patch.visible = false
	$SquigglingSprite.InactiveSquiggling()
	for p in PartsOfPath:
		p.Explote(ParentRock)
	BeforeEarthquake.emit()

func HitLavaFace(time, anim):
	lavaFace.play("tap")
	await get_tree().create_timer(time).timeout
	lavaFace.play(anim)

func ActiveDesquebrajado(numTouch):
	var num = roundi(NumOfPart / PartsToBreak)
	var min = num * numTouch
	num = num + (num * numTouch)
	print(min)
	print(num)
	for i in range(min,num):
		PartsOfPath[i].Appear()
		await get_tree().create_timer(0.02).timeout

func EmitEarthquake():
	lavaFace.get_node("AnimationPlayer").play("lava_face_anim")
	Earthquake.emit()
	
	

func ChangeLavaFace():
	nextLavaFace.visible = true
	nextLavaFace.get_node("AnimationPlayer").play("RESET")
	nextLavaFace.get_node("AnimationPlayer").play("lava_face_anim_back")

func SetTrueVisibility():
	await get_tree().create_timer(1.2).timeout
	disabled = false
	$Glow.visible = true
	$SquigglingSprite.ActiveSquiggling()

func TransparentPatch(num):
	var tween = get_tree().create_tween()
	tween.tween_method(MakeTransparence.bind(get_node("patch"+str(num))),1.0,0.0,1.5)

func MakeTransparence(value, patch):
	patch.self_modulate = Color(1,1,1,value)
