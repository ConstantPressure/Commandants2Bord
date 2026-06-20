extends Node2D

@onready var submarin: CharacterBody2D = $".."

var rotation_speed := 0.0
var target_rotation_speed := 0.0

@export var max_rotation_speed := 0.3
@export var rotation_speed_update_speed := 0.6

func _process(delta):
	#if Input.is_action_pressed("test_action2"):
		#target_rotation_speed = 1.0
	#elif Input.is_action_pressed("test_action3"):
		#target_rotation_speed = -1.0
	#else:
		#target_rotation_speed = 0.0
	
	rotation_speed = lerp(
		rotation_speed,
		target_rotation_speed,
		rotation_speed_update_speed * delta
	)

	submarin.rotation += rotation_speed * max_rotation_speed * delta
