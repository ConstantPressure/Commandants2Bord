extends Node2D

@onready var submarin: CharacterBody2D = $Submarin
@onready var spawner: Timer = $"Spawner"

const anchoy_res: Resource = preload("res://Scenes/Fishes/Anchovy.tscn")
const player_res: Resource = preload("res://Scenes/Player.tscn")

func _ready() -> void:
	Input.joy_connection_changed.connect(_on_input_changed)

func _process(delta: float) -> void:
	pass

func _on_input_changed(device: int, connected: bool) -> void:
	if connected:
		for child in submarin.get_children():
			if child.is_in_group("player") and child.player_id == device + 1:
				return
		var new_player = player_res.instantiate()
		new_player.player_id = device + 1
		submarin.add_child(new_player)
	else:
		for child in submarin.get_children():
			if child.is_in_group("player") and child.player_id == device + 1:
				child.queue_free()


func _on_spawner_timeout() -> void:
	var new_anchoy = anchoy_res.instantiate()
	new_anchoy.global_position = Vector2(20, 0)
	add_child(new_anchoy)
	print("spawned")
