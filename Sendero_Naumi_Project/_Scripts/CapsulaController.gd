extends Node2D

@onready var collider = $Collider/CollisionPolygon2D
@onready var trigger = $TriggerOutside
@onready var sprite = $Sprite2D
var isOutside

func _ready():
	trigger.area_entered.connect(Outsite)

func Outsite(x):
	var tween = get_tree().create_tween()
	tween.tween_property(sprite,"rotation",0,0.2).set_ease(Tween.EASE_IN_OUT)
	get_parent().IsOut()
