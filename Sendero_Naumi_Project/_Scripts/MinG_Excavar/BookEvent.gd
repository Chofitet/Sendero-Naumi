extends Node2D

var StateMachine
var anim 
var skeleton 
var isFinalInstance
var SpriteFade
var isInstancing
var isPencil = true
var topo
signal Restart
signal BookEvent
signal DrawFinish
var SpritePencil = preload("res://Sprites/ZonaMegafauna/pencil.png")
var SpriteBrush = preload("res://Sprites/ZonaMegafauna/brush - excavando.png")
var SquigglingBrush = preload("res://Sprites/ZonaMegafauna/squigglingExcavando/brushSQUIG - excavando.png")
var SquigglingPencil = preload("res://Sprites/ZonaMegafauna/squigglingExcavando/pencilSQUIG - excavando.png")
var Fade = preload("res://Scenes/Experiments/IndividualFade.tscn")
var fadeTexture = preload("res://addons/scene_manager/shader_patterns/diagonal.png")
var smilodonte = preload("res://Scenes/Zona_Megafauna/Smilodonte_Draw.tscn")
var gliptodonte = preload("res://Scenes/Zona_Megafauna/Gliptodonte_Draw.tscn")
var macrauquenia = preload("res://Scenes/Zona_Megafauna/Macrauquenia_Draw.tscn")
var megaterio = preload("res://Scenes/Zona_Megafauna/Megaterio_Draw.tscn")

var DrawaScenes : Dictionary = {
	"smilodonte": smilodonte,
	"glyptodon" : gliptodonte,
	"macrauquenia" : macrauquenia,
	"megaterio": megaterio
}
var NextInstance

func SetSkeleton(sk):
	for i in DrawaScenes:
		if i == sk:
			NextInstance = DrawaScenes[sk]
			if sk == "megaterio":
				isInstancing = true
				isFinalInstance = true
	$LibroController/libro/Label.text = sk

func IsPassingInstance(statemachine):
	isInstancing = true
	StateMachine = statemachine
	

func _ready():
	anim = $AnimationPlayer
	$btnContinue.pressed.connect(restartAll)
	$Button.button_down.connect(Draw)
	$Button.visible = false

func Draw():
	$Button.visible = false
	$pencil/SquigglingSprite.InactiveSquiggling()
	anim.play("pencil_anim")
	if isPencil: skeleton.StartFadeBone()
	else: skeleton.StartFadeLive()
	await anim.animation_finished
	if !isPencil: 
		$btnContinue.EnterAnim()
		DrawFinish.emit()
		return
	isPencil = false
	$pencil/Sprite2D.texture = SelectTexture()
	$pencil/SquigglingSprite.texture = SelectSquiggling()
	anim.play("Pencil_enter")
	$Button.visible = true
	await anim.animation_finished
	$pencil/SquigglingSprite.ActiveSquiggling()
	anim.play("pencil_idle")

func InstanceDraw(setCompleted = false):
	skeleton = NextInstance.instantiate()
	skeleton.get_node("Label").SetPencil($pencil/pencilPoint)
	$LibroController/libro/animales.add_child(skeleton)
	if setCompleted: skeleton.PlayCompleted()

func SelectTexture() -> Texture:
	if isPencil:
		return SpritePencil
	else: return SpriteBrush

func SelectSquiggling() -> Texture:
	if isPencil:
		return SquigglingPencil
	else: return SquigglingBrush

func SelectSpriteFade() -> String:
	if isPencil:
		return "bones"
	else: return "vivo"

func DoAnim(_topo, time = 1.5):
	topo = _topo
	BookEvent.emit(false)
	Restart.emit(false)
	await get_tree().create_timer(time).timeout
	anim.play("book_enter")
	await anim.animation_finished
	anim.play("Pencil_enter")
	await anim.animation_finished
	InstanceDraw()
	anim.play("pencil_idle")
	$pencil/SquigglingSprite.ActiveSquiggling()
	$Button.visible = true

func ShowCompletedAnimal(_topo):
	topo = _topo
	InstanceDraw(true)
	BookEvent.emit(false)
	Restart.emit(false)
	anim.play("book_enter")
	await anim.animation_finished
	$btnContinue.EnterAnim()
	

func restartAll():
	topo.EnableDisaneable(true)
	$btnContinue.visible = false
	if isInstancing: InstanceTransition()
	anim.play_backwards("book_enter")
	await anim.animation_finished
	ToRestart()
	if !isInstancing:
		queue_free()
		return
	

func InstanceTransition():
	var instance = Fade.instantiate()
	get_parent().get_parent().add_child(instance)
	instance.init(fadeTexture,2,true)
	await get_tree().create_timer(2).timeout
	ChangeInstanceMinigame()
	Restart.emit(true,true)
	var instance2 = Fade.instantiate()
	get_parent().get_parent().add_child(instance2)
	instance2.init(fadeTexture,2,false,false)
	queue_free()

func ToRestart():
	skeleton.queue_free()
	isPencil = true
	$pencil/Sprite2D.texture = SelectTexture()
	$pencil/SquigglingSprite.texture = SelectSquiggling()
	BookEvent.emit(true)
	
func ChangeInstanceMinigame():
	if isFinalInstance:
		BookEvent.emit(false)
		StateMachine.Trigger_On_Child_Transition("Fin")
	else:
		pass
		StateMachine.Trigger_On_Child_Transition("Juego")


