extends Area2D
var rocks := []
var tim = false
signal MoveToCenter

func Agrup(body):
	if !tim:
		rocks.append(body)
		
	

func Ungrup(body):
	if !tim:
		rocks.erase(body)

func SetParent():
	for r in rocks:
		var i = len(rocks)
		r.Freeze()
		r.reparent(self)
		add_child(r)
		r.vibing()

func time():
	tim = true
	
	var anim = $AnimationPlayer
	anim.play("shake")
	await anim.animation_finished
	MoveToCenter.emit(1)
