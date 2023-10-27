extends Sprite2D

func RockDefeat():
	get_node("ShardEmitter").shatter()
	get_node("Timer").start()
