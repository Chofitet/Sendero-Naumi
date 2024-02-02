extends Sprite2D
var hotspots := []
var countSpots
var isComplete
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
	if i == countSpots:
		DiscoverHueso()

func DiscoverHueso():
	z_index = 1
	isComplete = true
	get_parent().CheckTrue()
