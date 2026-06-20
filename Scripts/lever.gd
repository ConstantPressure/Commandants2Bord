extends Area2D

var lever_rotation := 0.0
var lever_target_rotation := 0.0

@export var lever_rotation_speed_update_speed := 0.6
@export var link_name: String
@onready var link = get_node("../"+link_name) if link_name else null

func _ready():
	set_process_input(false)

func _process(delta: float) -> void:
	$ColorRect2.rotation = lever_rotation * PI * 0.3
	
	if link and link.lever_target_rotation != lever_target_rotation:
		return
	
	lever_rotation = lerp(
		lever_rotation,
		lever_target_rotation,
		lever_rotation_speed_update_speed * delta
	)

func _input(event: InputEvent) -> void:
	if event.is_action("ui_right"):
		if event.is_pressed():
			lever_target_rotation = 1
		if not event.is_pressed() and lever_target_rotation != 0:
			lever_target_rotation = lever_rotation
	if event.is_action("ui_left"):
		if event.is_pressed():
			lever_target_rotation = -1
		if not event.is_pressed() and lever_target_rotation != 0:
			lever_target_rotation = lever_rotation

func exit():
	lever_target_rotation = lever_rotation
