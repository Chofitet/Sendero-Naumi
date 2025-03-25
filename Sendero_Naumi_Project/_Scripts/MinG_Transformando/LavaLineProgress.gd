extends Line2D

@export var Lava : Sprite2D
@export var numTramo : int
var isDrawing
var i = 0

func _physics_process(delta):
	if isDrawing:
		var relative_position = Lava.global_position - global_position
		add_point(relative_position)
		var ArrayPoints = get_points( )
		i = ArrayPoints.size()


func ActivateLava():
	isDrawing = true
	if numTramo == 0 : return
	var stringTramo = "tramo" + str(numTramo)
	SoundManager.play("lava",stringTramo)
