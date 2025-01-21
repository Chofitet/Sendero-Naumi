extends Sprite2D

signal onFloor1
signal onFloor2
signal onFloor3

func SetActualFloor(num):
	if num == 0: onFloor1.emit()
	elif num == 1: onFloor2.emit()
	elif num == 2: onFloor3.emit()
	
