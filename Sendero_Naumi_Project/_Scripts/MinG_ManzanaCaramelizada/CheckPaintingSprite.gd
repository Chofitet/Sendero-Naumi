extends Sprite2D
@export var target_color : Color
@export var tolerance : float

func CheckAllColor():
	if CheckEachPixelColor():
		print("paint")
	else:
		print("notPaint")

func CheckEachPixelColor():
	var img = texture.get_image()
	
	for x in range(img.get_width()):
		for y in range(img.get_height()):
			var pixel_color = img.get_pixel(x,y)
			if pixel_color.a == 0:
				continue
			if IsColorSimilar(pixel_color, target_color):
				return false
	
	return true

func IsColorSimilar(color1,color2) -> bool:
	return !color1.is_equal_approx(color2)

func _process(delta):
	print(Engine.get_frames_per_second())
