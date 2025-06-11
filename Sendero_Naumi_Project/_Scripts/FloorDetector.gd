extends Sprite2D

signal ChangingFloor
signal onFloor1
signal onFloor2
signal onFloor3
signal onFloor4

signal toFloor1
signal toFloor2
signal toFloor3
signal toFloor4

func ChangingToFlor(num):
	if num == 0: toFloor1.emit()
	elif num == 1: toFloor2.emit()
	elif num == 2: toFloor3.emit()
	elif num == 3: toFloor4.emit()

func SetActualFloor(num):
	ChangingFloor.emit()
	if num == 0: onFloor1.emit()
	elif num == 1: onFloor2.emit()
	elif num == 2: onFloor3.emit()
	elif num == 3: onFloor4.emit()
	
