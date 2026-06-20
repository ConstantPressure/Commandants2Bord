extends Node2D

@onready var submarin: CharacterBody2D = $".."

var speed := 0.0
var target_speed := 0.0

@export var max_speed := 300                        
@export var speed_update_speed := 0.2


func _process(delta: float) -> void:
	if Input.is_action_pressed("test_action1"):
		target_speed = 1.0
	elif Input.is_action_pressed("test_action4"):
		target_speed = -1.0
	else:
		target_speed = 0.0
	
	speed = lerp(
		speed,
		target_speed,
		speed_update_speed * delta
	)
	
	submarin.speed = speed * max_speed
