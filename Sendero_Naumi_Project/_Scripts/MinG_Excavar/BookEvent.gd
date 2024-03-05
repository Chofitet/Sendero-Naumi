extends Node2D

@onready var anim = $AnimationPlayer
@export var StateMachine : Node
var skeleton 
var SpritePencil = load("res://Sprites/ZonaMegafauna/pencil.png")
var SpriteBrush = load("res://Sprites/ZonaMegafauna/brush - excavando.png")
var Fade = load("res://Scenes/Experiments/IndividualFade.tscn")
var fadeTexture = load("res://addons/scene_manager/shader_patterns/diagonal.png")
var isFinalInstance
var SpriteFade
var fadeFactor
var isfading
var isInstancing
var skCount = 0
var isPencil = true
signal Restart

func SetSkeleton(sk):
	for i in $LibroController/libro.get_children():
		if i.name == sk:
			skeleton = i
			skCount += 1
			if skCount == 2:
				isInstancing = true
			if sk == "megaterio":
				isInstancing = true
				isFinalInstance = true
		
	$LibroController/libro/Label.text = sk
	

func _ready():
	$btnContinue.pressed.connect(restartAll)
	$Button.button_down.connect(Draw)
	$Button.visible = false
	visible = false
	anim.play("book_enter")
	await anim.animation_finished
	anim.play("RESET")
	await anim.animation_finished
	visible = true

func Draw():
	$Button.visible = false
	anim.play("pencil_anim")
	fadeFactor = 1
	SpriteFade = skeleton.get_node(SelectSpriteFade())
	isfading = true
	await anim.animation_finished
	if !isPencil: 
		$btnContinue.visible = true
		$LibroController/libro/Label.visible = true
		return
	isPencil = false
	$pencil/Sprite2D.texture = SelectTexture()
	anim.play("Pencil_enter")
	$Button.visible = true
	await anim.animation_finished
	anim.play("pencil_idle")

func SelectTexture() -> Texture:
	if isPencil:
		return SpritePencil
	else: return SpriteBrush

func SelectSpriteFade() -> String:
	if isPencil:
		return "bones"
	else: return "vivo"

func DoAnim():
	Restart.emit(false)
	anim.play("book_enter")
	await anim.animation_finished
	anim.play("Pencil_enter")
	await anim.animation_finished
	anim.play("pencil_idle")
	$Button.visible = true
	

func _process(delta):
	if isfading:
		fadeFactor -= delta * 0.5
		if fadeFactor <= 0:
			isfading = false
		SpriteFade.get_material().set_shader_parameter("cutoff", fadeFactor) 

func restartAll():
	Restart.emit(true)
	anim.play_backwards("book_enter")
	$btnContinue.visible = false
	await anim.animation_finished
	ToRestart()
	if !isInstancing: 
		return
	var instance = Fade.instantiate()
	get_parent().get_parent().add_child(instance)
	instance.init(fadeTexture,2,true)
	await get_tree().create_timer(2).timeout
	ChangeInstanceMinigame()
	Restart.emit(true,true)
	var instance2 = Fade.instantiate()
	get_parent().get_parent().add_child(instance2)
	instance2.init(fadeTexture,2,false,false)

func ToRestart():
	$LibroController/libro/Label.visible = false
	skeleton.get_node("vivo").get_material().set_shader_parameter("cutoff", 1)
	skeleton.get_node("bones").get_material().set_shader_parameter("cutoff", 1)
	isPencil = true
	$pencil/Sprite2D.texture = SelectTexture()
	
func ChangeInstanceMinigame():
	if isFinalInstance:
		StateMachine.Trigger_On_Child_Transition("Fin")
	else:
		StateMachine.Trigger_On_Child_Transition("Juego")


