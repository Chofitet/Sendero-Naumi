extends Control

var RocksTribuna :=[]
@export var Instances :=[]
@export var stateToChange: Node
@export var Zoisita : Texture2D
@export var Halita : Texture2D
@export var Espato : Texture2D
@export var moraleja: ColorRect
@onready var anim = $BackgroundPivot/AnimBackground
@onready var animMask = $Mask/AnimMask
var isPlayerWin
signal PlayerLose
var StateMachine
signal Moraleja1
signal Moraleja2
signal Moraleja3

func _ready():
	anim.animation_finished.connect(DoMask)
	animMask.animation_finished.connect(DoMoraleja)
	StateMachine = get_parent().get_parent().get_parent()
	get_parent().get_parent().Transitioned.connect(Reset)
	
	

func ChangeTextureRocks():
	for r in $BackgroundPivot/TribunaLeft.get_children():
		if r.has_method("ChangeTexture"):
			r.ChangeTexture(GetRocktexture())
			r.setAnim("waiting")
	
	for r in $BackgroundPivot/TribunaRigth.get_children():
		if r.has_method("ChangeTexture"):
			r.ChangeTexture(GetRocktexture())
			r.setAnim("waiting")

func DoMask(x):
	if x == "RESET": return
	animMask.play("circle_anim")
	if x == "Anim_left": 
		isPlayerWin = true
	else : 
		isPlayerWin = false
	await animMask.animation_finished
	for r in $BackgroundPivot/TribunaLeft.get_children():
		if r.has_method("setAnim"):
			r.setAnim("idle")

func DoMoraleja(x):
	if x == "RESET": return
	if !isPlayerWin:
		PlayerLose.emit()
		return
	
	
	if get_node(Instances[0]).visible:
		Moraleja1.emit()
	elif get_node(Instances[1]).visible:
		Moraleja2.emit()
	elif get_node(Instances[2]).visible:
		Moraleja3.emit()

func RetryInstance():
	StateMachine.Trigger_On_Child_Transition("Juego", true)
	await get_tree().create_timer(0.5).timeout
	Reset()
	

func Reset():
	ChangeTextureRocks()
	anim.play("RESET")
	animMask.play("RESET")
	$Particula/CPUParticles2D.visible = false
	$Particula/CPUParticles2D2.visible = false

func GetRocktexture()-> Texture2D:
	if get_node(Instances[0]).visible:
		return Zoisita
	elif get_node(Instances[1]).visible:
		return Halita
	elif get_node(Instances[2]).visible:
		return Espato
	return null

func GetLabel()-> String:
	if get_node(Instances[0]).visible:
		return "[center][b]LA ZOISITA 
PERTENECE AL GRUPO DE LOS SILICATOS[/b]

[b]CONSTITUYEN EL 95%[/b]
DE LA CORTEZA TERRESTRE

ES UN GRUPO [b]PETROGÉNICO[/b],
ES DECIR QUE
[b]SON LOS MINERALES
QUE FORMAN A LAS ROCAS[/b]"
	elif get_node(Instances[1]).visible:
		return "[center][b]LAS HALITAS 
PERTENCEN AL GRUPO HALOGENURO[/b]

NO TIENEN ASPECTO METÁLICO,
POSEEN POCA DUREZA
Y MUCHOS SON SOLUBLES EN AGUA

[b]LA MAYORÍA SON INCOLOROS[/b]
[/center]"
	elif get_node(Instances[2]).visible:
		return "[center][b]LOS ESPATOS DE ISLANDIA
PERTENECEN A LOS CARBONATOS[/b]

 [b]SUELEN ENCONTRARSE EN ZONAS ÁRIDAS[/b]
DE LA CORTEZA TERRESTRE

[b]SON MINERALES DE POCA DUREZA[/b]
Y COLORES MUY DIVERSOS
[b] SE DISUELVEN FACILMENTE[/b]
EN AMBIENTES ACUOSOS ÁCIDOS [/center]"
	return ""

