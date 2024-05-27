extends Area2D
var inArea
@export var PhantomCam : PhantomCamera2D
@export var ZoomFactor : Vector2
@export var timeToZoom : float
signal zooming

func _ready():
	area_entered.connect(Set_Bool_True)
	area_exited.connect(Set_Bool_false)

func Set_Bool_True(x):
	if x.is_in_group("Player"): 
		inArea = true
		zooming.emit()

func Set_Bool_false(x):
	if x.is_in_group("Player"):
		inArea = false

func _physics_process(delta):
	if inArea:
		PhantomCam._set_zoom_cam(ZoomFactor,timeToZoom*60)
	else:
		PhantomCam._set_zoom_cam(Vector2.ONE,timeToZoom*60)
