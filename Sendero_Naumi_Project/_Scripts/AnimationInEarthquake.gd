extends AnimationPlayer

func OnEarthquake():
	Input.vibrate_handheld(1500)
	play("Earthquake")

func OnSmallEarthquake():
	Input.vibrate_handheld(600)
	play("Small_Earthquake")

func StopLava():
	stop()
