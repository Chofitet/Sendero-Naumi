extends Node2D

@onready var area2d = $Area2D
@onready var timer = $Timer
@export var AnimInApple : Node2D
var onArea : bool
var index = 0
var pegotes :=[]
var pegotesManzana :=[]
var lastPosition
var apple
var isComplete

func _ready():
	area2d.area_entered.connect(AppleOnArea)
	area2d.area_exited.connect(AppleOnArea)
	timer.timeout.connect(AddPegote)
	for p in $Pegotes.get_children():
		pegotes.append(p)
	for p in AnimInApple.get_children():
		pegotesManzana.append(p)
		p.visible = false

func AppleOnArea(x):
	if !x.is_in_group("apple"):return
	apple = x
	timer.start()
	AddPegote()

func AppleOutArea(x):
	if !x.is_in_group("apple"):return
	apple = null
	timer.stop()

func AddPegote():
	print(position)
	if lastPosition == apple.global_position: return
	lastPosition = apple.global_position
	for p in pegotes:
		if p.isOnArea:
			pegotes.remove_at(pegotes.find(p))
			p.queue_free()
			pegotesManzana[index].visible = true
			index += 1
			if index == pegotesManzana.size():
				isComplete = true
				get_parent().CheckTrue()
			return
