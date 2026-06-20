extends Node2D

@onready var submarin: CharacterBody2D = $".."

var max_speed: float = 250
const speed_up: float = 50.0
var speed: float = 0


var player_in: int = -1

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_pressed("test_action1"): # forward
		if speed < max_speed:
			speed += speed_up * delta
	elif Input.is_action_pressed("test_action4"): # backward
		if speed > -max_speed / 2:
			speed -= speed_up * delta
	submarin.speed = speed
