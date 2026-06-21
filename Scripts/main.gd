extends Node2D

@onready var submarin: CharacterBody2D = $Submarin

const anchoy_res: Resource = preload("res://Scenes/Fishes/Anchovy.tscn")
const player_res: Resource = preload("res://Scenes/Player.tscn")
@onready var pouleto: Sprite2D = $End/Pouleto
@onready var end_timer: Timer = $End/EndTimer
@onready var end_item_1: Area2D = $EndItem1
@onready var end_item_2: Area2D = $EndItem2
@onready var end_item_3: Area2D = $EndItem3

var items_found: int = 0

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
		new_player.position = $PlayerSpawner.position
		submarin.add_child(new_player)
	else:
		for child in submarin.get_children():
			if child.is_in_group("player") and child.player_id == device + 1:
				child.queue_free()


func _on_end_body_entered(body: Node2D) -> void:
	if body.name == "Submarin":
		pouleto.show()
		end_timer.start()

func _on_end_timer_timeout() -> void:
	get_tree().quit()

func _on_end_item_1_body_entered(body: Node2D) -> void:
	if body.name == "Submarin":
		items_found += 1
		end_item_1.queue_free()

func _on_end_item_2_body_entered(body: Node2D) -> void:
	if body.name == "Submarin":
		items_found += 1
		end_item_2.queue_free()

func _on_end_item_3_body_entered(body: Node2D) -> void:
	if body.name == "Submarin":
		items_found += 1
		end_item_3.queue_free()
