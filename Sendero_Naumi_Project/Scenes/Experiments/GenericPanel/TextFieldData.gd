extends Resource
class_name TextField

@export_multiline var Text : String
@export var SizePanel : Vector2 = Vector2.ZERO
@export var Position : Vector2 = Vector2.ZERO
@export var PanelTheme : Theme

@export var buttons : Array[ButtonPanel] :
	set(new_value):
		buttons = new_value

@export var NumOfContent = 0
