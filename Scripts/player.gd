extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $"AnimatedSprite2D"

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var player_id: int = 1
var prefix: String
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
	
	if event.is_action_pressed(prefix + "use"):
		var closest = $ControllableDetector.get_closest()
		if closest:
			if closest.player:
				return
			controlled_utility = closest
			controlled_utility.player = self
			controlled_utility.enter()

func move(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed(prefix + "jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis(prefix + "left", prefix + "right")
	if direction:
		anim.play("move")
		velocity.x = direction * SPEED
		anim.flip_h = direction < 0
	else:
		anim.play("idle")
		velocity.x = 0
	move_and_slide()
