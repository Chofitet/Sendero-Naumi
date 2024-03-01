extends Control
@onready var anim = $AnimationPlayer 
@onready var btn = $Button
@onready var baldeManzana = $baldeManzana
@export var manzana : Node2D
@export var pivotManzana : Marker2D
signal MoveBackground

func _ready():
	btn.button_down.connect(DoAnim)

func DoAnim():
	btn.visible = false
	anim.play("Prick_Apple")
	await  anim.animation_finished
	var tween = get_tree().create_tween()
	tween.tween_property(manzana, "position", pivotManzana.position,1).set_ease(Tween.EASE_OUT)
	await  tween.finished
	MoveBackground.emit()
	var tween2 = get_tree().create_tween()
	tween2.tween_property(baldeManzana,"position", Vector2(baldeManzana.position.x - 800,baldeManzana.position.y),1).set_ease(Tween.EASE_IN)
	
