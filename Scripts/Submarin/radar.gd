extends Area2D

@onready var radar_ui: MarginContainer = $"CanvasLayer/RadarUI"

var fish_icon = preload("res://icon.svg")
var rock_icon = preload("res://icon.svg")
var checkpoint_icon = preload("res://icon.svg")

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("fishes"):
		radar_ui.add_object(body, fish_icon)
	if body.is_in_group("rock"):
		radar_ui.add_object(body, rock_icon)
	if body.is_in_group("checkpoint"):
		radar_ui.add_object(body, checkpoint_icon)


func _on_body_exited(body: Node2D) -> void:
	radar_ui.remove_object(body)
