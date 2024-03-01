extends Control
@onready var encimera = $center/EncimeraPivot
var pivotsPos := []
var i : int
signal IngredientChanged

func _ready():
	for f in $center/pivots.get_children():
		pivotsPos.append(f)

func ChangeIngredient():
	i = i + 1
	var tween = get_tree().create_tween()
	tween.tween_property(encimera,"position",Vector2(pivotsPos[i].position.x,encimera.position.y),1).set_ease(Tween.EASE_IN_OUT)
	await  tween.finished
	IngredientChanged.emit()
