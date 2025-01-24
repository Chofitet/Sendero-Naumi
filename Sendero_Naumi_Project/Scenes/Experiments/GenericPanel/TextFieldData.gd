extends Resource
class_name TextField

@export_multiline var Text : String

@export var buttons : Array[ButtonPanel] :
	set(new_value):
		buttons = new_value
