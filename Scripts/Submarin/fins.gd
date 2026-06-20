extends Node2D

@onready var submarin: CharacterBody2D = $".."

var rotation_speed := 0.0
var target_rotation_speed := 0.0

@export var max_rotation_speed := 0.3
@export var rotation_speed_update_speed := 0.6

func _process(delta):
	rotation_speed = $Lever.lever_rotation
	#if $Lever.lever_rotation == 0:
		#target_rotation_speed = $Lever2.lever_rotation
	#else:
		#target_rotation_speed = $Lever.lever_rotation
	#
	#rotation_speed = lerp(
		#rotation_speed,
		#target_rotation_speed,
		#rotation_speed_update_speed * delta
	#)

	submarin.rotation += rotation_speed * max_rotation_speed * delta
