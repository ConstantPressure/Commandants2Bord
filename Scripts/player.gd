extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $"AnimatedSprite2D"
@onready var submarin: Node2D = get_parent()

const SPEED = 300.0
const FLY_SPEED = 100.0
const JUMP_VELOCITY = -400.0
var player_id: int = 1
var prefix: String
var is_flying: bool = false
var controlled_utility = null

func _ready() -> void:
	anim.play("idle")
	prefix = "p" + str(player_id) + "_"

func _physics_process(delta: float) -> void:
	if not controlled_utility:
		move(delta)
	
	self.global_rotation = 0

func _input(event: InputEvent) -> void:
	if controlled_utility:
		controlled_utility._input(event)
		return
	
	handle_controllable(event)
	handle_interractable(event)

func handle_controllable(event):
	if event.is_action_pressed(prefix + "use"):
		var closest = $ControllableDetector.get_closest()
		if closest:
			if closest.player:
				return
			controlled_utility = closest
			controlled_utility.player = self
			controlled_utility.enter()

func handle_interractable(event):
	if event.is_action_pressed(prefix + "use"):
		var closest = $InterractableDetector.get_closest()
		if closest:
			if closest.is_in_group("water_pump"):
				submarin.health = min(submarin.health + 1, 100)
			if closest.is_in_group("electrical_box"):
				closest.change_state()
				submarin.is_ligth_on = closest.activated
				print(submarin.is_ligth_on)

func move(delta):
	if not is_on_floor() and not is_flying:
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed(prefix + "jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed(prefix + "fly"):
		is_flying = not is_flying

	if not is_flying:
		var direction := Input.get_axis(prefix + "left", prefix + "right")
		if direction:
			anim.play("move")
			velocity.x = direction * SPEED
			anim.flip_h = direction < 0
		else:
			anim.play("idle")
			velocity.x = 0
	else:
		var direction := Input.get_axis(prefix + "left", prefix + "right")
		
		if direction:
			anim.play("move")
			velocity.x = direction * FLY_SPEED
			anim.flip_h = direction < 0
		else:
			anim.play("idle")
			velocity.x = 0
	
		var direction_y := Input.get_axis(prefix + "up", prefix + "down")
		velocity.y = direction_y * FLY_SPEED
	
	move_and_slide()
