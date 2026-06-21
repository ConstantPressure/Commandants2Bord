extends Node2D

var player: Node2D = null

func _ready():
	set_process_input(false)
	self.scale /= 2

func _process(delta: float) -> void:
	if player:
		player.move(delta)
		self.position = player.position + Vector2(0, -20)

func enter():
	pass

func _input(event: InputEvent) -> void:
	if player:
		if event.is_action_pressed(player.prefix + "use"):
			if check_put_back_in_box():
				player.controlled_utility = null
				self.exit()
			elif check_do_reparation():
				repair()
				self.exit()

func exit():
	player = null
	self.queue_free()

func check_put_back_in_box():
	var closest_controllable = player.get_node("ControllableDetector").get_closest()
	return closest_controllable and closest_controllable.name == "PlankStorage"

func check_do_reparation():
	var closest_interractable = player.get_node("InterractableDetector").get_closest()
	return closest_interractable and closest_interractable.is_in_group("hole")

func repair():
	var closest_interractable = player.get_node("InterractableDetector").get_closest()
	
	closest_interractable.queue_free()
