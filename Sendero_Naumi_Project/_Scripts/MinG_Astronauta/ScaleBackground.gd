extends Polygon2D

func scaleTexture():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "texture_scale", Vector2(0.3,.3),1.5)
