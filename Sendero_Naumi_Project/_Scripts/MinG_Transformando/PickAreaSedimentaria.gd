extends Area2D
var rocks := []
var tim = false

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

func time():
	tim = true
