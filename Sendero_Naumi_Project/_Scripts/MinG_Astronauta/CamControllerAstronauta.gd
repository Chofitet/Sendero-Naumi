extends Camera2D
@export var FondoReference: Polygon2D
@export var phantom: PhantomCamera2D
@export var player: CharacterBody2D
var pointsFondo :=[]
var lastposition
var offsetx = 0
var offsety = 0

func _ready():
	var polygon = FondoReference.polygon
	for p in polygon:
		pointsFondo.append(p)

func Enable(x):
	enabled = x

func _physics_process(delta):
	var positionCam = position
	var limitXLeft = pointsFondo[0].x + get_viewport_rect().size.x/2
	var limitXRigth = pointsFondo[1].x - get_viewport_rect().size.x/2
	var limitYUP= pointsFondo[0].y + get_viewport_rect().size.y/2
	var limitYDown= pointsFondo[3].y - get_viewport_rect().size.y/2
	
	
	phantom.inLimit = false
	if !(position.x > limitXRigth-10 or position.x < limitXLeft+10 or position.y > limitYDown -10 or position.y < limitYUP + 10): return
	
	if(position.x > limitXRigth-10):
		phantom.inLimit = true
		offsetx = -(player.position.x - limitXRigth)
		phantom.FinalOffsetVector.x = offsetx
	elif (position.x < limitXLeft+10):
		phantom.inLimit = true
		offsetx= -(player.position.x - limitXLeft)
		phantom.FinalOffsetVector.x = offsetx
	else: offsetx = 0
	
	if(position.y > limitYDown -10):
		phantom.inLimit = true
		offsety = -(player.position.y - limitYDown)
		phantom.FinalOffsetVector.y = offsety
	elif (position.y < limitYUP + 10):
		phantom.inLimit = true
		offsety = -(player.position.y - limitYUP)
		phantom.FinalOffsetVector.y = offsety
	else: offsety = 0
	
	

