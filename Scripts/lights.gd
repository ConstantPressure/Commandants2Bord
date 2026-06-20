extends Node2D

@export var base_color: Color = Color.WHITE
@onready var submarin: CharacterBody2D = $"../.."

@export var normal_lights: Curve = Curve.new()
@export var angry_lights: Curve = Curve.new()


var current_curve = self.normal_lights
var time = 0
var mult = 1

func set_lights(color: Color):
	color.r = 1.0 - submarin.health / 100.0
	color.g = submarin.health / 100.0
	color.b = submarin.health / 100.0
	if submarin.health <= 30:
		self.current_curve = angry_lights
	else:
		self.current_curve = normal_lights

	for light in get_children():
		light.get_node("PointLight2D").color = color

func _process(delta: float) -> void:
	time = fmod(time + delta, 2.0)
	set_lights(base_color * mult)
	mult = current_curve.sample(time / 2.0)
