extends Node2D

@onready var aimer: Node2D = $"Aimer"

var player: Node2D = null
var angle: float = 0.0
var rotate_speed: float = 1

func _ready() -> void:
	aimer.hide()
	set_process_input(false)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(player.prefix + "use"):
		self.exit()
		player.controlled_utility = null

func _process(delta: float) -> void:
	if player:
		if aimer.visible:
			aimer.show()
		if Input.is_action_pressed(player.prefix + "right") and angle < 0.9:
			angle += rotate_speed * delta
		if Input.is_action_pressed(player.prefix + "left") and angle > -1.3:
			angle -= rotate_speed * delta
		aimer.rotation = angle

func exit() -> void:
	player = null
	aimer.hide()
