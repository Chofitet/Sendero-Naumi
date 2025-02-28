@tool
extends Sprite2D
var DrawEnero = false
var DrawAgosto = false
var DrawDic21 = false
var DrawDic25 = false
var DrawDic29 = false
var DrawDic31 = false
var cintapng = load("res://Sprites/ZonaAstronomia/cintas.png")
@onready var background = $background

@onready var InstanceReference = get_parent().get_parent().get_parent().get_parent()

func _ready():
	InstanceReference.get_parent().Transitioned.connect(SetSlot)

@export var SlotPos: Vector2:
	set(value):
		SlotPos = value

@export var SlotRotation: float:
	set(value):
		SlotRotation = value

@export var Slotscale: Vector2:
	set(value):
		Slotscale = value

@export var OffsetA: Vector2:
	set(value):
		OffsetA = value


func _process(delta):
	background.offset = offset
	queue_redraw()

func _draw():
	if DrawEnero:
		DrawSlots(Vector2(-38.78,-20.86), preload("res://Sprites/ZonaAstronomia/Respuestas_Calendar/enero opcion 1 - calendario.png"))
	if DrawAgosto:
		DrawSlots(Vector2(-29.4,-2.245),preload("res://Sprites/ZonaAstronomia/Respuestas_Calendar/agosto opcion 3 - calendario.png"))
	if DrawDic21:
		DrawSlots(Vector2(10.035,-11.135),preload("res://Sprites/ZonaAstronomia/Respuestas_Calendar/dic21 opcion 3 - calendario.png"))
	if DrawDic25:
		DrawSlots(Vector2(-6.39,-6.85),preload("res://Sprites/ZonaAstronomia/Respuestas_Calendar/dic25 opcion 1 - calendario.png"))
	if DrawDic29:
		DrawSlots(Vector2(-23.018,-2.355),preload("res://Sprites/ZonaAstronomia/Respuestas_Calendar/dic29 opcion 3 - calendario.png"))
	if DrawDic31:
		DrawSlots(Vector2(10.057,-6.28),preload("res://Sprites/ZonaAstronomia/Respuestas_Calendar/23,54 opcion 3 calendario.png"),Vector2(0.515,0.515),Vector2(-102.105,-102.535))

func DrawSlots(positionSlot, _texture,SlotScale = Vector2(0.225,0.225), offsetC = Vector2(-40,-40)):
	var _position = positionSlot * Vector2(100,100) + offset * (1/SlotScale.x)
	draw_set_transform(Vector2.ZERO, SlotRotation,SlotScale)
	draw_texture(_texture, _position, modulate)
	draw_texture(cintapng, _position + offsetC*(1/SlotScale.x), modulate)

func SetSlot():
	var i = InstanceReference.get_num_instance()
	if i >= 1: DrawEnero = true
	if i >= 2:  DrawAgosto = true
	if i >= 3:  DrawDic21 = true
	if i >= 4: DrawDic25 = true
	if i >=5: DrawDic29 = true
	if i >=6: 
		DrawDic31 = true
