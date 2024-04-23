extends Control
@onready var computer = $Computer
var MeteorosUI :=[]

func _ready():
	for m in $Panel/HBoxContainer.get_children():
		MeteorosUI.append(m.get_child(1))

func CheckMeteoro(index):
	visible = true
	var anim : AnimationPlayer = MeteorosUI[index] 
	anim.play("check")
	await anim.animation_finished
	computer.Setface("surprice")
	await get_tree().create_timer(2).timeout
	visible = false
