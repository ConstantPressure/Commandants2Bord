extends Area2D

var fish_icon = preload("res://icon.svg")
var rock_icon = preload("res://icon.svg")
var checkpoint_icon = preload("res://icon.svg")

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	print(body.get_groups())
	if body.is_in_group("fishes"):
		print("passage")
		$"CanvasLayer/RadarUI".add_object(body, fish_icon)
	if body.is_in_group("rock"):
		$"CanvasLayer/RadarUI".add_object(body, rock_icon)
	if body.is_in_group("checkpoint"):
		$"CanvasLayer/RadarUI".add_object(body, checkpoint_icon)
