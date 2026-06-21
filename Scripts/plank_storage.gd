extends Area2D

@onready var pick_up_sound: AudioStreamPlayer2D = $PickUpSound

var player: Node2D = null
@export var plank_scene: PackedScene

func _ready():
	set_process_input(false)

func _process(delta: float) -> void:
	pass

func enter():
	var plank = plank_scene.instantiate()
	plank.player = player
	player.controlled_utility = plank
	plank.enter()
	get_parent().add_child(plank)
	pick_up_sound.play()
	self.exit()

func _input(event: InputEvent) -> void:
	pass

func exit():
	player = null
