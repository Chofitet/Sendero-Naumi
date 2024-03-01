extends Sprite2D
var hotspots := []
var countSpots
var isComplete
signal AllSpots
var i : int
func _ready():
	for HS in get_children():
		if HS is Area2D:
			hotspots.append(HS)
	countSpots = hotspots.size()
	

func checkHotSpots():
	i = 0
	for HS in hotspots:
		if !HS.isTrue : return
		i = i + 1
		print(i)
	if i == countSpots:
		isComplete = true
		AllSpots.emit()


