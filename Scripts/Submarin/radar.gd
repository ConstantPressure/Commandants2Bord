extends Area2D

@onready var radar_ui: MarginContainer = $"CanvasLayer/RadarUI"
@onready var scaner: Polygon2D = $CanvasLayer/Scaner
@export var scaner_curve: Curve

var blip_fish = preload("res://Assets/Submarine/Blip_003.png")
var curve_time: float = 0.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	scaner.color.a = 0.5 * scaner_curve.sample((sin(curve_time) + 1) / 2)
	curve_time += delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("fishes"):
		radar_ui.add_object(body, blip_fish)

func _on_body_exited(body: Node2D) -> void:
	radar_ui.remove_object(body)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("fishes"):
		radar_ui.add_object(area, blip_fish)

func _on_area_exited(area: Area2D) -> void:
	radar_ui.remove_object(area)
