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
@onready var SquigglingSprite = $SquigglingSprite
@onready var SquigglingSpriteBig = $SquigglingSpriteBig

func _ready():
	SquigglingSpriteBig.visible = false
	if AppearChild: 
		move_child(get_node("FrontTexture"),0)
		ScaleOfChild = get_node("FrontTexture").scale
	initScale = scale
	initPosition = position
	initRotation = rotation_degrees
	button.button_down.connect(BtnPress)
	if inactiveInReady:
		BlockButton(false)
	if EditableButton : return
	adjustRect(true)
	
	

func adjustRect(isexpand = false):
	button.set_size(rect.size)
	button.set_position(rect.position)
	button.pivot_offset = rect.size/2
	if !isexpand:
		button.scale = Vector2(30,30)
	else :
		button.scale = Vector2.ONE

func BtnPress():
	if !isInCenter:
		get_parent().BlockOthersClues(self,false)
		isInCenter = true
		z_index = 2
		ToCenter.emit()
		MakeAnim(Vector2.ZERO, HighQualityTexture, extra_scale, angleInCenter,1, false,true)
		SquigglingSprite.visible = false
		await get_tree().create_timer(0.4).timeout
		SquigglingSpriteBig.visible = true
		get_parent().FinalAnim()
		get_parent().BlockOthersClues(self,false)
		adjustRect()
	elif isInCenter and !hasClue:
		get_parent().BlockOthersClues(self,true)
		SquigglingSpriteBig.visible = false
		isInCenter = false
		z_index = 0
		NoCenter.emit()
		if otherPosition == null:
			MakeAnim(initPosition, lowQualityTexture, Vector2.ONE, initRotation,0,false,false,true)
		else:
			MakeAnim(otherPosition.position, lowQualityTexture, Vector2.ONE, otherPosition.rotation_degrees,0,false,false,true)
		await get_tree().create_timer(0.4).timeout
		get_parent().FinalAnim()
		adjustRect(true)
	elif isInCenter and hasClue:
		get_parent().BlockOthersClues(self,true)
		SquigglingSpriteBig.visible = false
		isInCenter = false
		if !inPlace: ToInventary.emit()
		inPlace = true
		NoCenter.emit()
		z_index = 0
		MakeAnim(ToPosition, lowQualityTexture,inventary_scale, 0,0,true,false,true)
		await get_tree().create_timer(0.4).timeout
		adjustRect(true)
		get_parent().FinalAnim()
	
	
	

func MakeAnim(pos, _texture, extra_scale : Vector2 = Vector2(1,1), rotateAngle : float = 0 , index = 0, _hasClue = false, isChildVisible = false, squiggling = false):
	z_index = 1
	get_parent().StartAnim()
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
	button.visible = true
	z_index = index
	if AppearChild:
		ShowChild(isChildVisible)
	if squiggling: 
		SquigglingSprite.visible = true

var inFrot
func ShowChild(isVisible):
	if isVisible:
		self_modulate = Color(0,0,0,0)
		get_node("FrontTexture").visible = true
		for p in get_node("FrontTexture").get_children():
			if p is CPUParticles2D:
				p.restart()
				p.emitting = true

	
	else:
		inFrot = true
		self_modulate = Color(1,1,1,1)
		get_node("FrontTexture").visible = false
		
func ChangeTexture(_texture,extrascale):
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

func SetSquiggling(x):
	if x: SquigglingSprite.ActiveSquiggling()
	else: SquigglingSprite.InactiveSquiggling()
