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
var animMoraleja

func _ready():
	animMoraleja = moraleja.get_node("animMoraleja")
	anim.animation_finished.connect(DoMask)
	animMask.animation_finished.connect(DoMoraleja)
	get_parent().get_parent().Transitioned.connect(Reset)
	
	

func ChangeTextureRocks():
	for r in $BackgroundPivot/TribunaLeft.get_children():
		if r.has_method("ChangeTexture"):
			r.ChangeTexture(GetRocktexture())
	
	for r in $BackgroundPivot/TribunaRigth.get_children():
		if r.has_method("ChangeTexture"):
			r.ChangeTexture(GetRocktexture())

func DoMask(x):
	if x == "RESET": return
	animMask.play("circle_anim")
	if x == "Anim_left": 
		moraleja.get_node("correcto/Label").text = "CORRECTO"
	else : 
		moraleja.get_node("correcto/Label").text = "INCORRECTO"

func DoMoraleja(x):
	if x == "RESET": return
	animMoraleja.play("AnimMoraleja")

func Reset():
	ChangeTextureRocks()
	anim.play("RESET")
	animMoraleja.play("RESET")
	animMask.play("RESET")
	moraleja.get_node("Panel/RichTextLabel").text = GetLabel()
	$Particula/CPUParticles2D.visible = false
	$Particula/CPUParticles2D2.visible = false
	if get_node(Instances[2]).visible:
		moraleja.get_node("Panel/Button").state_to_change = stateToChange
		moraleja.get_node("Panel/Button").isEndOfGame = true

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
