extends Area2D
var rocks := []
var tim

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
		r.get_parent().remove_child(r)
		add_child(r)

func time():
	tim = true
