extends Control

@onready var obj1 = $HBoxContainer/obj1
@onready var btn1 :Button = $HBoxContainer/obj1/Button
@onready var icon1 = $HBoxContainer/obj1/Icon
@onready var obj2 = $HBoxContainer/obj2
@onready var btn2 :Button = $HBoxContainer/obj2/Button
@onready var icon2 = $HBoxContainer/obj2/Icon
@onready var obj3 = $HBoxContainer/obj3
@onready var btn3 :Button = $HBoxContainer/obj3/Button
@onready var icon3 = $HBoxContainer/obj3/Icon
@onready var Book = preload("res://Scenes/Zona_Megafauna/evento_libro.tscn")
@export var ParentBook : Control
@export var topoController : CharacterBody2D
@onready var Items : Array[TextureRect] = [obj1,obj2,obj3]
@onready var btns : Array[Button] = [btn1,btn2,btn3]
@onready var Icons : Array[TextureRect] = [icon1,icon2,icon3]

@export var SmilodonteTexture : Texture

@export var GliptodonteTexture : Texture

@export var MacrauqueniaTexture : Texture

@export var MegaterioTexture : Texture

var i = 0
var InventaryItems : Dictionary = {
	0: "",
	1: "",
	2: ""
}

func SetInstance(x):
	obj1.visible = false
	obj2.visible = false
	obj3.visible = false
	for index in InventaryItems: InventaryItems[index] = ""
	for btn in btns:
		btn.pressed.disconnect(DoBookAnim)
	i = 0
	if x == 0:
		obj1.visible = true
		obj2.visible = true
		obj3.visible = true
	elif x == 1:
		obj1.visible = true
		Items.append(obj1)
		Items[0].get_node("AnimationPlayer").play("RESET")

func SetSkeletonFind(skeleton):
	if i in InventaryItems:
		InventaryItems[i] = skeleton
		btns[i].pressed.connect(DoBookAnim.bind(skeleton))
		btns[i].disabled = false
		
		match skeleton.name:
			"smilodon": Icons[i].texture = SmilodonteTexture
			"glyptodon": Icons[i].texture = GliptodonteTexture
			"macrauchenia": Icons[i].texture = MacrauqueniaTexture
			"megatherium": Icons[i].texture = MegaterioTexture
	
		i += 1

func AppearIcon():
	Items[0].get_node("AnimationPlayer").play("appearIcon")
	Items.remove_at(0)

func DoBookAnim(skeleton):
	var instance = Book.instantiate()
	ParentBook.add_child(instance)
	topoController.ConnectBook(instance)
	instance.SetSkeleton(skeleton.name)
	instance.ShowCompletedAnimal(topoController)

func Disanable(state):
	if state == "Fin":
		visible = false
