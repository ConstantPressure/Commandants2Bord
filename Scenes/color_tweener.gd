extends Node

@export var start_color: Color
@export var end_color: Color

@onready var node_list: Array[Node2D] = [$"../Objects", $"../Cockpit", $"../Fins", $"../Motor", $"../PlankStorage", $"../WaterPump", $"../ElectricalBox", $"../Boundaries"]

func _ready():
	set_my_color(start_color)
	var tween = get_tree().create_tween()
	tween.tween_method(self.set_my_color, start_color, start_color, 1)
	tween.tween_method(self.set_my_color, start_color, end_color, 2)

func set_my_color(color):
	for node in node_list:
		node.modulate = color
	
	for node in get_tree().get_nodes_in_group("player"):
		node.modulate = color
