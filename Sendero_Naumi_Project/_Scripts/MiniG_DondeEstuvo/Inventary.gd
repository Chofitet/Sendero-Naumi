extends Control

@export var Objects : =[]
@export var ObjectsShowInTrue : NodePath
@onready var Spots = $MarginContainer/HBoxContainer.get_children()
var i : int = 0
@onready var offset = get_parent().get_node("ScreenCenter")
@onready var overlay = get_parent().get_node("Overlay")

func _ready():
	for O in Objects:
		var o = get_node(O)
		o.ToInventary.connect(SetInventarySpot.bind(o))
		o.ToCenter.connect(SetOverlayTrue.bind(o))
		o.NoCenter.connect(SetOverlayFalse.bind(o))

func SetInventarySpot(obj):
	Spots[i].self_modulate = Color(1,1,1,1)
	var spotOffset = Vector2(Spots[i].size.x / 2 + 20, Spots[i].size.y /2 + 20)
	print(Spots[i].size.x)
	print(spotOffset)
	obj.ToPosition = Spots[i].position - offset.position + spotOffset
	i += 1
	if i == Objects.size() - 1:
		get_node(ObjectsShowInTrue).visible = true

func SetOverlayTrue(obj):
	overlay.visible = true
	for O in Objects:
		if get_node(O) != obj:
			get_node(O).button.visible = false

func SetOverlayFalse(obj):
	overlay.visible = false
	for O in Objects:
		get_node(O).button.visible = true
