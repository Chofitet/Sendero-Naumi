extends Node2D

@onready var collider = $Collider/CollisionPolygon2D
@onready var trigger = $TriggerOutside
@onready var capsulaOut = $pivot/capsulaOut
@onready var capsulaIn = $pivot/capsulaIn
@onready var PanelOut = $PanelOutArea
@onready var pivot = $pivot
var isOutside
signal openCapsula

func _ready():
	trigger.area_entered.connect(Outsite)
	$TriggerInside.area_entered.connect(OpenCapsula)
	PanelOut.area_entered.connect(OutPanel)

func Outsite(x):
	capsulaOut.visible = true
	var tween = get_tree().create_tween()
	tween.tween_property(pivot,"rotation",0,0.2).set_ease(Tween.EASE_IN_OUT)
	get_parent().IsOut()

func OpenCapsula(x):
	if !x.is_in_group("Player"): return
	var tween = get_tree().create_tween()
	tween.tween_property(pivot,"rotation",deg_to_rad(144),0.2).set_ease(Tween.EASE_IN_OUT)
	$TriggerInside.queue_free()
	

func OutPanel(x):
	if !x.is_in_group("Player"): return
	PlayerVariables.EmitActivePause()
	openCapsula.emit()
	PanelOut.area_entered.disconnect(OutPanel)
