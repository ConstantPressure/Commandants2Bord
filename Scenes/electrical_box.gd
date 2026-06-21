extends Area2D

var activated := true

func change_state():
	if activated:
		activated = false
	else:
		activated = true
