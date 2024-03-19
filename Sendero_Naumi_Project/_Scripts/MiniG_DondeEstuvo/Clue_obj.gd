@tool
extends Sprite2D

signal ToInventary
signal ToCenter
signal NoCenter
var initPosition
var initScale
@export var HighQualityTexture : Texture
@onready var lowQualityTexture = texture
@export var AnimatedSpeed : float = 0.3
@export var hasClue : bool
@export var angleInCenter : float
var ToPosition : Vector2 = Vector2.ONE
var isInCenter : bool = false
@export var extra_scale : Vector2 = Vector2(1,1)
@onready var button = $Button
var inPlace : bool
var otherPosition : Marker2D

func _ready():
	initScale = scale
	initPosition = position
	button.pressed.connect(BtnPress)

func adjustRect():
	button.set_anchors_preset(Control.PRESET_FULL_RECT)
	
func BtnPress():
	if !isInCenter:
		isInCenter = true
		z_index = 2
		ToCenter.emit()
		MakeAnim(Vector2.ZERO, HighQualityTexture, Vector2.ONE, angleInCenter)
	elif isInCenter and !hasClue:
		isInCenter = false
		z_index = 0
		NoCenter.emit()
		if otherPosition == null:
			MakeAnim(initPosition, lowQualityTexture)
		else:
			MakeAnim(otherPosition.position, lowQualityTexture)
	elif isInCenter and hasClue:
		isInCenter = false
		if !inPlace: ToInventary.emit()
		inPlace = true
		NoCenter.emit()
		z_index = 0
		MakeAnim(ToPosition, lowQualityTexture,extra_scale)


func MakeAnim(pos, _texture, extra_scale : Vector2 = Vector2(1,1), rotateAngle : float = 0):
	button.visible = false
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",pos,AnimatedSpeed)
	var tween2 = get_tree().create_tween()
	tween2.tween_property(self,"scale",CalculateScaleVector(_texture) * extra_scale,AnimatedSpeed)
	tween2.tween_callback(ChangeTexture.bind(_texture,extra_scale))
	var tween3 = get_tree().create_tween()
	tween3.tween_property(self,"rotation",deg_to_rad(rotateAngle),AnimatedSpeed).set_ease(Tween.EASE_OUT)
	


func ChangeTexture(_texture,extrascale):
	button.visible = true
	texture = _texture
	scale = Vector2.ONE * extrascale
	button.position = Vector2(-_texture.get_width()/2, -_texture.get_height()/2)


func CalculateScaleVector(_texture) -> Vector2:
	var vector
	var h : float
	var v : float
	h = float(_texture.get_width())  / float(texture.get_width()) 
	v = float(_texture.get_height()) / float(texture.get_height())
	print(vector)
	vector = Vector2(h,v)
	return vector
