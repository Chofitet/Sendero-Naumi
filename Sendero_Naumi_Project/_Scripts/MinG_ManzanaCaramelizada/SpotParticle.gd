extends Area2D
var isComplete

func Set_Complete():
	isComplete = true
	get_parent().CheckPartialChildTrue()

