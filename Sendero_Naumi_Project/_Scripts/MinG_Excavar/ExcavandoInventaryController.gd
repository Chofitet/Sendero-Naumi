extends Control

@onready var obj1 = $HBoxContainer/obj1
@onready var btn1 :Button = $HBoxContainer/obj1/Button
@onready var icon1 = $HBoxContainer/obj1/Icon
@onready var anim1= $HBoxContainer/obj1/AnimationPlayer
@onready var obj2 = $HBoxContainer/obj2
@onready var btn2 :Button = $HBoxContainer/obj2/Button
@onready var icon2 = $HBoxContainer/obj2/Icon
@onready var anim2= $HBoxContainer/obj2/AnimationPlayer
@onready var obj3 = $HBoxContainer/obj3
@onready var btn3 :Button = $HBoxContainer/obj3/Button
@onready var icon3 = $HBoxContainer/obj3/Icon
@onready var anim3= $HBoxContainer/obj3/AnimationPlayer
@onready var obj4 = $HBoxContainer/obj4
@onready var btn4 :Button = $HBoxContainer/obj4/Button
@onready var anim4= $HBoxContainer/obj4/AnimationPlayer
@onready var icon4 = $HBoxContainer/obj4/Icon
@onready var Book = preload("res://Scenes/Zona_Megafauna/evento_libro.tscn")
@export var ParentBook : Control
@export var topoController : CharacterBody2D
@onready var Items : Array[TextureRect] = [obj1,obj2,obj3,obj4]
@onready var btns : Array[Button] = [btn1,btn2,btn3,btn4]
@onready var Icons : Array[TextureRect] = [icon1,icon2,icon3,icon4]
@onready var Anims : Array[AnimationPlayer] = [anim1,anim2,anim3,anim4]
@export var Overlay : ColorRect
var PassFirstInstance = false
var inSecondInstance = false
var isBookOutIn = ""
signal newBook
@export var SmilodonteTexture : Texture
@export var GliptodonteTexture : Texture
@export var MacrauqueniaTexture : Texture
@export var MegaterioTexture : Texture

@export var SmilodonSkeleton : Sprite2D
@export var GlyptodonSkeleton : Sprite2D
@export var MacraucheniaSkeleton : Sprite2D
@export var MegaterioSkeleton : Sprite2D

@export var Statemachine : Node

var i = 1
var InventaryItems : Dictionary = {
	0: "",
	1: "",
	2: "",
	3:""
}


func SetInstance(x):
	if x == 0: pass
	elif !PassFirstInstance:
		SetSkeletonFind(SmilodonSkeleton)
		AppearIcon(true)
		SetSkeletonFind(GlyptodonSkeleton)
		AppearIcon(true)
		SetSkeletonFind(MacraucheniaSkeleton)
		AppearIcon(true)
		isBookOutIn = ""
	if x == 0:
		obj2.visible = true
		obj3.visible = true
		obj4.visible = true
		PassFirstInstance = true
	elif x == 1:
		PassFirstInstance = false
		inSecondInstance = true
		obj1.visible = true
		obj2.visible = true
		obj3.visible = true
		obj4.visible = true
		i = 0
	

func SetSkeletonFind(skeleton):
	if i in InventaryItems:
		InventaryItems[i] = skeleton
		btns[i].pressed.connect(DoBookAnim.bind(skeleton,btns[i]))
		#btns[i].disabled = false
		
		match skeleton.name:
			"smilodon": Icons[i].texture = SmilodonteTexture
			"glyptodon": Icons[i].texture = GliptodonteTexture
			"macrauchenia": Icons[i].texture = MacrauqueniaTexture
			"megatherium": Icons[i].texture = MegaterioTexture
	
		i += 1

func AppearIcon(addIndex = false):
	if !addIndex: EnabledAllIcons()
	var addOffsetIndex = 0
	if PassFirstInstance or addIndex: addOffsetIndex = 1
	Items[0 + addOffsetIndex].get_node("AnimationPlayer").play("appearIcon")
	Items.remove_at(0 + addOffsetIndex)
	

func DoBookAnim(skeleton, btn):
	var sk = skeleton.name
	if isBookOutIn == skeleton.name : return
	newBook.emit()
	if isBookOutIn != "":
		for A in Anims:
			var AIndex = Anims.find(A)
			var inventaryIndex = InventaryItems.find_key(skeleton)
			if AIndex != inventaryIndex:
				A.play("disabled")
			else: btn.disabled = true
		await  get_tree().create_timer(0.6).timeout
	var instance = Book.instantiate()
	ParentBook.add_child(instance)
	topoController.ConnectBook(instance)
	instance.SetSkeleton(skeleton.name)
	instance.ConnectSignal(newBook, true)
	instance.ShowCompletedAnimal(topoController)
	instance.ShutBook.connect(CleanInventarySlot)
	isBookOutIn = skeleton.name
	if i == 4: 
		instance.IsPassingInstance(Statemachine)
	if inSecondInstance and i == 1:
		instance.IsPassingInstance(Statemachine,true)
	await  get_tree().create_timer(0.6).timeout
	EnabledAllIcons()
		

func DisableAllIcons():
	for A in Anims:
		A.play("disabled")

func EnabledAllIcons():
	for A in Anims:
		A.play("enabled")

func CleanInventarySlot():
	isBookOutIn = ""
	EnabledAllIcons()
	await get_tree().create_timer(0.6).timeout
	Overlay.visible = false

func Disanable(state):
	if state == "Fin":
		visible = false
