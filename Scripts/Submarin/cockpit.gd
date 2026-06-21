extends Node2D

@onready var aimer: Node2D = $"Aimer"
@onready var radar: Area2D = $"Aimer/Radar"
@onready var radar_ui: CanvasLayer = $"Aimer/Radar/CanvasLayer"
@onready var scaner_ui: Polygon2D = $"Aimer/Radar/CanvasLayer/Scaner"

var player: Node2D = null
var angle: float = 0.0
var rotate_speed: float = 1

func _ready() -> void:
	hide_all()
	set_process_input(false)

func enter():
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(player.prefix + "use"):
		player.controlled_utility = null
		self.exit()

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
	if player:
		show_all()
		if Input.is_action_pressed(player.prefix + "right") and angle < 0.9:
			angle += rotate_speed * delta
		if Input.is_action_pressed(player.prefix + "left") and angle > -1.3:
			angle -= rotate_speed * delta
		aimer.rotation = angle
		scaner_ui.rotation = angle

func exit() -> void:
	player = null
	hide_all()
