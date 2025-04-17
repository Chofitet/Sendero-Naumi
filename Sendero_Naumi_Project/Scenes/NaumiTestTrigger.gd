extends Panel


@onready var label = $num
@onready var rigthBTN = $rigth
@onready var leftBTN = $left
@onready var changescene = $ButtonChangeScene3
var num

func _ready():
	num = 0
	rigthBTN.pressed.connect(Incruse)
	leftBTN.pressed.connect(Decrece)
	changescene.pressed.connect(NaumiDebug)

func Incruse():
	num = float(label.text) + 1
	label.text = str(num)

func Decrece():
	num = float(label.text) - 1
	label.text = str(num)

func NaumiDebug():
	PlayerVariables.SetDebugMode(true)
	PlayerVariables.SetNaumiDebugNum(num)
