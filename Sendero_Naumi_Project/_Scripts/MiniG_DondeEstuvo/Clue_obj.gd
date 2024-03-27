@tool
extends Sprite2D

signal ToInventary
signal ToCenter
signal NoCenter
var initPosition
var initScale
var initRotation
@export var HighQualityTexture : Texture
@onready var lowQualityTexture = texture
@export var AnimatedSpeed : float = 0.3
@export var hasClue : bool
@export var angleInCenter : float
var ToPosition : Vector2 = Vector2.ONE
var isInCenter : bool = false
@export var extra_scale : Vector2 = Vector2(1,1)
@export var inventary_scale : Vector2 = Vector2(1,1)
@onready var button = $Button
@onready var rect = get_rect()
@export var inactiveInReady : bool
var inPlace : bool
@export var otherPosition : Marker2D
@export var AppearChild : bool = false
@export var EditableButton : bool = false
var ScaleOfChild

func _ready():
	if AppearChild: 
		move_child(get_node("FrontTexture"),0)
		ScaleOfChild = get_node("FrontTexture").scale
	initScale = scale
	initPosition = position
	initRotation = rotation_degrees
	button.pressed.connect(BtnPress)
	if inactiveInReady:
		BlockButton(false)
	if EditableButton : return
	adjustRect()

func adjustRect():
	button.set_size(rect.size)
	button.set_position(rect.position)

func BtnPress():
	if !isInCenter:
		get_parent().BlockOthersClues(self,false)
		isInCenter = true
		z_index = 2
		ToCenter.emit()
		MakeAnim(Vector2.ZERO, HighQualityTexture, extra_scale, angleInCenter,1, false,true)
	elif isInCenter and !hasClue:
		get_parent().BlockOthersClues(self,true)
		isInCenter = false
		z_index = 0
		NoCenter.emit()
		if otherPosition == null:
			MakeAnim(initPosition, lowQualityTexture, Vector2.ONE, initRotation)
		else:
			MakeAnim(otherPosition.position, lowQualityTexture, Vector2.ONE, otherPosition.rotation_degrees)
		await get_tree().create_timer(1).timeout
		adjustRect()
	elif isInCenter and hasClue:
		get_parent().BlockOthersClues(self,true)
		isInCenter = false
		if !inPlace: ToInventary.emit()
		inPlace = true
		NoCenter.emit()
		z_index = 0
		MakeAnim(ToPosition, lowQualityTexture,inventary_scale, 0,0,true)
		await get_tree().create_timer(1).timeout
		adjustRect()
	
	
	

func MakeAnim(pos, _texture, extra_scale : Vector2 = Vector2(1,1), rotateAngle : float = 0 , index = 0, _hasClue = false, isChildVisible = false):
	z_index = 1
	button.visible = false
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",pos,AnimatedSpeed)
	var tween2 = get_tree().create_tween()
	tween2.tween_property(self,"scale",CalculateScaleVector(_texture) * extra_scale,AnimatedSpeed)
	tween2.tween_callback(ChangeTexture.bind(_texture,extra_scale))
	var tween3 = get_tree().create_tween()
	tween3.tween_property(self,"rotation",deg_to_rad(rotateAngle),AnimatedSpeed).set_ease(Tween.EASE_OUT)
	if _hasClue:
		var tween4 = get_tree().create_tween()
		tween4.tween_property(self,"global_position",pos,AnimatedSpeed).set_ease(Tween.EASE_OUT)
	await tween.finished
	z_index = index
	if AppearChild:
		ShowChild(isChildVisible)

var inFrot
func ShowChild(isVisible):
	if isVisible:
		self_modulate = Color(0,0,0,0)
		get_node("FrontTexture").visible = true
	else:
		inFrot = true
		self_modulate = Color(1,1,1,1)
		get_node("FrontTexture").visible = false

func ChangeTexture(_texture,extrascale):
	button.visible = true
	texture = _texture
	scale = Vector2.ONE * extrascale
	if AppearChild: 
		if !inFrot:
			get_node("FrontTexture").scale = Vector2.ONE
		else:
			get_node("FrontTexture").scale = ScaleOfChild
			inFrot = false
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

func BlockButton(x):
	button.visible = x
