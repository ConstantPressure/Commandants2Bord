extends Node2D

@onready var submarin: CharacterBody2D = $".."

var speed := 0.0
var target_speed := 0.0

@export var max_speed := 300                        

func _process(delta: float) -> void:
	submarin.speed = $Lever.lever_rotation * max_speed
