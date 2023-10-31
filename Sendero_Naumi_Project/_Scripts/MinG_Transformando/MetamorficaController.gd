extends Sprite2D
var heat1
var heat2
var i = 1

func _physics_process(delta):
	if heat1:
		i -= delta * 0.08
		i = clamp(i,0.7,1)
		modulate = Color(1, i, i, 1)
	if heat2:
		i -= delta * 0.08
		i = clamp(i,0,0.7)
		modulate = Color(1, i, i, 1)

func Heat1():
	heat1 = true

func Heat2():
	heat2 = true
	heat1 = false
