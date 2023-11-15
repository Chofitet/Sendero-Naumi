extends Button
var NumOfTap = 3
signal Earthquake
signal BeforeEarthquake
signal SmallEarthquake
var timer 

func _ready():
	timer = get_node("Timer")
	timer.timeout.connect(EmitEarthquake)
	self.pressed.connect(Tap)

func Tap():
	#NumOfTap -= 1
	#Input.vibrate_handheld(100)
	#if (NumOfTap != 0): SmallEarthquake.emit()
	Input.vibrate_handheld(300)
	NumOfTap = 3
	visible = false
	timer.start()
	BeforeEarthquake.emit()

func EmitEarthquake():
	Earthquake.emit()

func SetTrueVisibility():
	visible = true
