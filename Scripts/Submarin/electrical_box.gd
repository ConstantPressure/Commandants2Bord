extends Area2D

@onready var power_down_sound: AudioStreamPlayer2D = $PowerDownSound
@onready var power_up_sound: AudioStreamPlayer2D = $PowerUpSound

var activated := true

func change_state():
	if activated:
		activated = false
		power_down_sound.play()
	else:
		activated = true
		power_up_sound.play()
