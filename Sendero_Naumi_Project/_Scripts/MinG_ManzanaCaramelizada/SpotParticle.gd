extends Area2D
var isComplete

func Set_Complete():
	isComplete = true
	$CollisionShape2D.set_deferred("disabled",true)
	get_parent().CheckPartialChildTrue()

