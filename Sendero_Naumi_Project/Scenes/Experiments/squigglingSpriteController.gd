extends Sprite2D
@export var ActiveInBegining : bool = true

func _ready():
	visible = ActiveInBegining

func InactiveSquiggling():
	visible = false

func ActiveSquiggling():
	visible = true
