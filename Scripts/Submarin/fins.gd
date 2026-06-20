extends Node2D

@onready var submarin: CharacterBody2D = $".."

var player_in: int = -1
const steer_speed: float = 1.5
const steer_input_speed: float = 2.0

var steer_angle: float = 0.0
var steer_return: float = 3.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_pressed("test_action2"):
		steer_angle = move_toward(steer_angle, 1.0, steer_input_speed * delta)
	elif Input.is_action_pressed("test_action3"):
		steer_angle = move_toward(steer_angle, -1.0, steer_input_speed * delta)

	var speed_factor: float = submarin.speed / 10000.0
	var rotation_delta: float = steer_angle * steer_speed * speed_factor * delta
	if abs(submarin.speed) > 0.1:
		submarin.direction = submarin.direction.rotated(rotation_delta).normalized()
		submarin.rotation = submarin.direction.angle()
