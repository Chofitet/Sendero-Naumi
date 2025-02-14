extends Control
var RockTexture : Texture: 
	set(value):
		RockTexture = value
		$Parts/Piedra.texture = RockTexture
var anim : AnimationPlayer
var shardEmitter
@export var isWinner : bool
var timer
var btnvolver
signal fight

func init(_texture,isflip, btn, _isWinner, otherRock, VectorScale = Vector2(0.639,0.639), offset = Vector2.ZERO):
	$Parts/Piedra.texture = _texture
	$Parts/Piedra.scale = VectorScale
	$Parts/Piedra.offset = offset
	scale.x = isflip
	$Parts/Piedra/ShardEmitter.setShatter()
	isWinner = _isWinner
	btn.pressed.connect(Fight)
	otherRock.fight.connect(BlockAnim)
	timer = get_node("Timer")
	timer.timeout.connect(finishAnim)
	shardEmitter = get_node("Parts/Piedra/ShardEmitter")
	anim = $AnimPiedra 
	anim.play("EnterAnim")
	await anim.animation_finished
	anim.play("Rock_Idle")


func Fight(): 
	anim.play("Rock_Punch")
	fight.emit()
	timer.start()

func finishAnim():
	if !isWinner:
		shardEmitter.shatter()
		for p in get_node("Parts").get_children():
			if p.name != "Piedra":
				p.visible = false
		await get_tree().create_timer(3).timeout
		get_parent().PassInstance()
	else:
		await get_tree().create_timer(1.3).timeout
		PlayIdle()

func BlockAnim():
	anim.play("Rock_Block")
	timer.start()

func PlayIdle():
	anim.play("Rock_Idle")
