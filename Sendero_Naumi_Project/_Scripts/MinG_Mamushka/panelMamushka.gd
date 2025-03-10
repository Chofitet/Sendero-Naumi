extends Panel

func get_out_screen():
	var vector2 = get_viewport_rect().get_center() - global_position
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position",global_position + (vector2 * Vector2(2,2) * -1),1).set_trans(Tween.TRANS_SPRING)
	await  tween.finished
	visible = false
func Connect(MamushkaController):
	MamushkaController.ToFinal.connect(get_out_screen)
