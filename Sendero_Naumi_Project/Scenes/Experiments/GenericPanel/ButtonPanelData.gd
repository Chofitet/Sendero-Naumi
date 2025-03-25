extends Resource
class_name ButtonPanel

@export var Place : place
@export var texture : Texture
@export var label : String
@export var dontPassPanel : bool
@export var exitPanel : bool

enum place {
	rigth,
	center,
	left
}
