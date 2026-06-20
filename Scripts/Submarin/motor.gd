extends Node2D

@onready var submarin: CharacterBody2D = $".."

var max_speed: float = 10000
const speed_up: float = 300.0
const speed_down: float = 80.0
var speed: float = 0


var player_in: int = -1

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_pressed("test_action1"): # forward
		if speed < max_speed:
			speed += speed_up * delta
	elif Input.is_action_pressed("test_action4"): # backward
		if speed > -max_speed:
			speed -= speed_up * delta
	elif speed > 0:
		speed -= speed_down * delta
		if speed < 0:
			speed = 0
	elif speed < 0:
		speed += speed_down * delta
		if speed > 0:
			speed = 0
	submarin.speed = speed
