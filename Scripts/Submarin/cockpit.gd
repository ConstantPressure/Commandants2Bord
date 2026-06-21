extends Node2D

@onready var aimer: Node2D = $"Aimer"
@onready var radar: Area2D = $"Aimer/Radar"
@onready var radar_ui: CanvasLayer = $"Aimer/Radar/CanvasLayer"

var prefix: String = ""
var angle: float = 0.0
var rotate_speed: float = 1

func _ready() -> void:
	#hide_all()
	pass

func _input(event: InputEvent) -> void:
	pass

func show_all() -> void:
	if not aimer.visible:
		aimer.show()
	if not radar.visible:
		radar.show()
	if not radar_ui.visible:
		radar_ui.show()

func hide_all() -> void:
	aimer.hide()
	radar.hide()
	radar_ui.hide()

func _process(delta: float) -> void:
	if not prefix.is_empty():
		show_all()
		if Input.is_action_pressed(prefix + "right") and angle < 0.9:
			angle += rotate_speed * delta
		if Input.is_action_pressed(prefix + "left") and angle > -1.3:
			angle -= rotate_speed * delta
		aimer.rotation = angle

func exit() -> void:
	prefix = ""
	hide_all()
