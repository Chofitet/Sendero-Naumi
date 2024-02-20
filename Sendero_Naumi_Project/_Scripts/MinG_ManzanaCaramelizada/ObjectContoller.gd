extends Control
@onready var object = $Object
@export var TextureObject : Texture
@export var initPosition : Node2D
@export var finalPosition : Node2D
@export var timeAnim : float
@export var FinalScale : Vector2
@export var FinalRotation: float

@export var TextureApple : Texture
@onready var apple = $manzana
@export var offsety : float
@export var FinalScaleM : Vector2
signal ObjectInPosition

func _ready():
	$Object/Sprite2D.texture = TextureObject
	$manzana/Sprite2D.texture = TextureApple
	$Button.button_down.connect(DoAnim)

func DoAnim():
	$Button.visible = false
	#Object
	var tweenPos = get_tree().create_tween()
	tweenPos.tween_property(object,"global_position",finalPosition.global_position, timeAnim)
	var tweenS = get_tree().create_tween()
	tweenS.tween_property(object.get_node("Sprite2D"),"scale", FinalScale, timeAnim)
	var tweenR = get_tree().create_tween()
	tweenR.tween_property(object, "rotation",deg_to_rad(FinalRotation),timeAnim)
	#Apple
	var tweenPos2 = get_tree().create_tween()
	tweenPos2.tween_property(apple,"position",Vector2.ZERO + Vector2(0,offsety), timeAnim)
	var tweenS2 = get_tree().create_tween()
	tweenS2.tween_property(apple.get_node("Sprite2D"),"scale", FinalScaleM, timeAnim)
	
	await tweenPos.finished
	visible = false
	ObjectInPosition.emit()
