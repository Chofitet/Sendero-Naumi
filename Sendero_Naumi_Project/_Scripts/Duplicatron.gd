@tool
extends StaticBody2D
var instance = preload("res://Scenes/Experiments/CollisionPolygon2DMaker.tscn")
var textureeee = preload("res://Sprites/ZonaAstronomia/asteroide 1 textura - astronauta.png")
var textureeeLineeee = preload("res://Sprites/ZonaAstronomia/dirtEdge.png")


@export var doDuplicate: bool:
	set(value):
		doDuplicate = value
		DuplicateAll()

func _ready():
	DuplicateAll()

func DuplicateAll():
	print("duplicanding")
	for c in get_children():
		if c is CollisionPolygon2D:
			var newInstance : CollisionPolygon2D
			newInstance = instance.new()
			add_child(newInstance)
			newInstance.set_owner(get_tree().get_edited_scene_root())
			newInstance._texture = textureeee
			newInstance._textureLine = textureeeLineeee
			newInstance.position = c.position
			newInstance.set_polygon(c.get_polygon())
