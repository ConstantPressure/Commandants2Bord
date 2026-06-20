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
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed(prefix + "jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis(prefix + "left", prefix + "right")
	if direction:
		anim.play("move")
		velocity.x = direction * SPEED
		anim.flip_h = direction < 0
	else:
		anim.play("idle")
		velocity.x = 0

	if not controlled_utility:
		move_and_slide()
	
func _input(event: InputEvent) -> void:
	if controlled_utility:
		controlled_utility._input(event)
		
		if event.is_action(prefix + "use") and event.is_pressed():
			if controlled_utility.has_method("exit"):
				controlled_utility.exit()
			controlled_utility = null
		
		return
	
	if event.is_action(prefix + "use") and event.is_pressed():
		controlled_utility = $UtilityDetector.get_closest()
		if controlled_utility:
			controlled_utility.prefix = self.prefix
	
	if event is InputEventKey:
		if event.pressed and event.is_action(prefix + "jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
