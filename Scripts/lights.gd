@tool
extends Node2D

var time = 0

var mult = 1
@export var base_color: Color = Color.WHITE:
	set(new_color):
		base_color = new_color
		set_lights(base_color * mult)

func set_lights(color):
	for light in get_children():
		light.color = color

func _process(delta: float) -> void:
	set_lights(base_color * mult)
	
	mult = (sin(time * 2) + 1) / 2 * 0.25 + 0.75
	time += delta
