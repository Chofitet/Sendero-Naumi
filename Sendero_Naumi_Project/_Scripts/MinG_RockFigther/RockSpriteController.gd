extends Control
var anim
var shardEmitter
@export var isWinner : bool
var overlay1
var overlay2
var timer
signal fight

func _ready():
	timer = get_node("Timer")
	get_node("TextureRect2/button").pressed.connect(Fight)
	timer.timeout.connect(finishAnim)
	shardEmitter = get_node("Parts/Piedra/ShardEmitter")
	anim = get_node("AnimPiedra")
	anim.play("Rock_Idle")
	overlay1 = $"../../../overlay1"
	overlay2 = $"../../../overlay2"

func Fight(): 
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
