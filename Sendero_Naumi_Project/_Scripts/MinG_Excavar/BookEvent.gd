extends Node2D

var StateMachine
var anim 
var skeleton 
var isFinalInstance
var SpriteFade
var fadeFactor
var fadeFactor2 
var isfading
var isInstancing
var isPencil = true
var topo
signal Restart
signal BookEvent
var SpritePencil = preload("res://Sprites/ZonaMegafauna/pencil.png")
var SpriteBrush = preload("res://Sprites/ZonaMegafauna/brush - excavando.png")
var SquigglingBrush = preload("res://Sprites/ZonaMegafauna/squigglingExcavando/brushSQUIG - excavando.png")
var SquigglingPencil = preload("res://Sprites/ZonaMegafauna/squigglingExcavando/pencilSQUIG - excavando.png")
var Fade = preload("res://Scenes/Experiments/IndividualFade.tscn")
var fadeTexture = preload("res://addons/scene_manager/shader_patterns/diagonal.png")

func SetSkeleton(sk):
	for i in $LibroController/libro/animales.get_children():
		i.visible = false
		i.get_node("bones").get_material().set_shader_parameter("inverted", true)
		i.get_node("vivo").get_material().set_shader_parameter("cutoff", 1)
		i.get_node("bones").get_material().set_shader_parameter("cutoff", 1)
		if i.name == sk:
			skeleton = i
			skeleton.visible = true
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
	skeleton.get_node("Label").visible = true
	anim.play("pencil_anim")
	fadeFactor = 1
	SpriteFade = skeleton.get_node(SelectSpriteFade())
	isfading = true
	await anim.animation_finished
	if !isPencil: 
		$btnContinue.EnterAnim()
		return
	fadeFactor2 = 0
	isPencil = false
	$pencil/Sprite2D.texture = SelectTexture()
	$pencil/SquigglingSprite.texture = SelectSquiggling()
	anim.play("Pencil_enter")
	$Button.visible = true
	await anim.animation_finished
	$pencil/SquigglingSprite.ActiveSquiggling()
	anim.play("pencil_idle")

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

func DoAnim(_topo):
	topo = _topo
	BookEvent.emit(false)
	Restart.emit(false)
	anim.play("book_enter")
	await anim.animation_finished
	anim.play("Pencil_enter")
	await anim.animation_finished
	anim.play("pencil_idle")
	$pencil/SquigglingSprite.ActiveSquiggling()
	$Button.visible = true
	

func _process(delta):
	if isfading:
		fadeFactor -= delta * 0.5
		if fadeFactor <= 0:
			isfading = false
		SpriteFade.get_material().set_shader_parameter("cutoff", fadeFactor) 
		if !isPencil:
			fadeFactor2 += delta * 0.5
			var otherSprite = skeleton.get_node("bones")
			otherSprite.get_material().set_shader_parameter("inverted", false) 
			otherSprite.get_material().set_shader_parameter("cutoff", fadeFactor2) 


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
	isPencil = true
	$pencil/Sprite2D.texture = SelectTexture()
	$pencil/SquigglingSprite.texture = SelectSquiggling()
	skeleton.get_node("Label").visible = false
	BookEvent.emit(true)
	
func ChangeInstanceMinigame():
	if isFinalInstance:
		BookEvent.emit(false)
		StateMachine.Trigger_On_Child_Transition("Fin")
	else:
		pass
		StateMachine.Trigger_On_Child_Transition("Juego")


