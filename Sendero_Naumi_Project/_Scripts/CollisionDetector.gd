extends Area2D
signal Area_entered
signal Body_entered

func _ready():
	area_entered.connect(get_area_entered)
	Body_entered.connect(get_body_entered)

func get_area_entered(x):
	emit_signal("Area_entered", x)

func get_body_entered(x):
	emit_signal("Body_entered",x)
