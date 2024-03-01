extends ColorRect
var _ShaderMaterial
var isFading
var fadeFactor
var isbackwards

func init(_texture,time : float = 2, backwards : bool = false, inverted : bool = true,_smoothness : float = 0.2, color : Color = Color(0,0,0,1)):
	_ShaderMaterial = get_material()
	isFading = true
	_ShaderMaterial.set_shader_parameter("inverted",inverted)
	_ShaderMaterial.set_shader_parameter("color",color)
	_ShaderMaterial.set_shader_parameter("custom_texture", _texture)
	_ShaderMaterial.set_shader_parameter("linear_fade", false)
	_ShaderMaterial.set_shader_parameter("smoothness", _smoothness)
	isbackwards = backwards
	if isbackwards: fadeFactor = 1
	else : fadeFactor = 0
	await get_tree().create_timer(time).timeout
	queue_free()


func _process(delta):
	if isFading:
		if !isbackwards:
			fadeFactor += delta * 1.2
			if fadeFactor >= 1:
				isFading = false
		else:
			fadeFactor -= delta * 1.2
			if fadeFactor <= 0:
				isFading = false

		_ShaderMaterial.set_shader_parameter("cutoff", fadeFactor) 
	
