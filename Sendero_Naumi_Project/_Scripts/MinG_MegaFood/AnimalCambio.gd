extends Sprite2D
@export var _textures :=[]
var i

func _ready():
	$Button.pressed.connect(press)

func press():
	if (_textures.size() >= i): i = 0
	texture = load(_textures[i])
	i +=1
	
