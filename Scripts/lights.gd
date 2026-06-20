extends Node2D

@export var base_color: Color = Color.WHITE
@onready var submarin: CharacterBody2D = $"../.."

var time = 0
var mult = 1

func set_lights(color: Color):
	color.r = 1.0 - submarin.health / 100.0
	color.g = submarin.health / 100.0
	color.b = submarin.health / 100.0
	for light in get_children():
		light.get_node("PointLight2D").color = color

func _process(delta: float) -> void:
	set_lights(base_color * mult)
	mult = (sin(time * 2) + 1) / 2 * 0.25 + 0.75
	time += delta
