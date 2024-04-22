extends Panel

func get_out_screen():
	var vector2 = get_viewport_rect().get_center() - global_position
	print(vector2)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position",global_position + (vector2 * -1),1).set_trans(Tween.TRANS_SPRING)

func Connect(MamushkaController):
	print(MamushkaController.name)
	MamushkaController.ToFinal.connect(get_out_screen)
