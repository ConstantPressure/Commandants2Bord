extends Area2D

@onready var radar_ui: MarginContainer = $"CanvasLayer/RadarUI"
@onready var scaner: Polygon2D = $CanvasLayer/Scaner
@export var scaner_curve: Curve

var fish_icon = preload("res://Assets/Submarine/Blip_003.png")
var rock_icon = preload("res://Assets/Submarine/Blip_003.png")
var checkpoint_icon = preload("res://Assets/Submarine/Blip_003.png")
var curve_time: float = 0.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	scaner.color.a = 0.5 * scaner_curve.sample((sin(curve_time) + 1) / 2)
	curve_time += delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("fishes"):
		radar_ui.add_object(body, fish_icon)
	if body.is_in_group("rock"):
		radar_ui.add_object(body, rock_icon)
	if body.is_in_group("checkpoint"):
		radar_ui.add_object(body, checkpoint_icon)


func _on_body_exited(body: Node2D) -> void:
	radar_ui.remove_object(body)
