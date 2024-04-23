extends Control
var anim
var shardEmitter
@export var isWinner : bool
@export var overlay1 : ColorRect
@export var overlay2 : ColorRect
var timer
var btnvolver
signal fight

func _ready():
	timer = get_node("Timer")
	get_node("TimePassInstance").timeout.connect(TimeOutPassLevel)
	get_node("TextureRect2/BigButton").pressed.connect(Fight)
	timer.timeout.connect(finishAnim)
	shardEmitter = get_node("Parts/Piedra/ShardEmitter")
	anim = get_node("AnimPiedra")
	anim.play("Rock_Idle")
	get_parent().get_parent().InstanceTrue.connect(EnterUI)
	btnvolver = $"../../../HUD"

func Fight(): 
	btnvolver.visible = false
	overlay1.Anim()
	overlay2.Anim()
	anim.play("Rock_Punch")
	fight.emit()
	timer.start()
	get_node("TimePassInstance").start()
	get_node("AnimUI").play("ExitScene")

func finishAnim():
	if isWinner:
		pass
		##anim.play("Rock_Idle")
	else:
		shardEmitter.shatter()
		for p in get_node("Parts").get_children():
			if p.name != "Piedra":
				p.visible = false

func BlockAnim():
	anim.play("Rock_Block")
	timer.start()
	get_node("AnimUI").play("ExitScene")

func EnterUI():
	get_node("AnimUI").play("EnterScene")

func TimeOutPassLevel():
	btnvolver.visible = true
