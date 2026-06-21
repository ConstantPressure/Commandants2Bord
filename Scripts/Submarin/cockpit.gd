extends Node2D

@onready var aimer: Node2D = $"Aimer"

var prefix: String = ""
var angle: float = 0.0
var rotate_speed: float = 1

func _ready() -> void:
	aimer.hide()

func _input(event: InputEvent) -> void:
	pass

func _process(delta: float) -> void:
	if not prefix.is_empty():
		if not aimer.visible:
			aimer.show()
		if Input.is_action_pressed(prefix + "right") and angle < 0.9:
			angle += rotate_speed * delta
		if Input.is_action_pressed(prefix + "left") and angle > -1.3:
			angle -= rotate_speed * delta
		aimer.rotation = angle

func exit() -> void:
	prefix = ""
	aimer.hide()
