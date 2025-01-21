extends Sprite2D
@export var ActiveInBegining : bool = true

func _ready():
	visible = ActiveInBegining

func InactiveSquiggling(x):
	visible = false

func ActiveSquiggling(x):
	visible = true
