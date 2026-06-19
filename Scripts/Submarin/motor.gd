extends Node2D

@onready var submarin: CharacterBody2D = $".."

var max_speed: float = 10000
var speed: float = 0

var player_in: int = -1

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_pressed("test_action1"):
		if speed < max_speed:
			speed += 400.0 * delta
	elif speed > 0:
		speed -= 200.0 * delta
	if speed < 0:
		speed = 0.0
	submarin.speed = speed
