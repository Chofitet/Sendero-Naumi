extends ProgressBar

@export var curveCharge : Curve
@export var TimeToDoCharge : float
signal finishCharge

#func StartLoad():
#	var tween = get_tree().create_tween()
#	tween.set_cu
#	tween.tween_property(self,"value",100,TimeToDoCharge).set_ease(curveCharge)
	
	
func StartLoad(timeToLoad : float = TimeToDoCharge):
	var tween := create_tween()
	tween.set_trans(Tween.TransitionType.TRANS_QUINT)
	tween.tween_method(
		func (progress):
		var curve_progress := curveCharge.sample(progress)
		value = lerp(0, 100, curve_progress), 0.0, 1.0, timeToLoad)
	
	await tween.finished
	visible = false
	finishCharge.emit()

