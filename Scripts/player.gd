extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $"AnimatedSprite2D"

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var controlled_utility = null

func _ready() -> void:
	anim.play("idle")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		anim.play("move")
		velocity.x = direction * SPEED
	else:
		anim.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if not controlled_utility:
		move_and_slide()
	
func _input(event: InputEvent) -> void:
	if controlled_utility:
		controlled_utility._input(event)
		
		if event.is_action("interact") and event.is_pressed():
			if controlled_utility.has_method("exit"):
				controlled_utility.exit()
			controlled_utility = null
		
		return
	
	if event.is_action("interact") and event.is_pressed():
		controlled_utility = $UtilityDetector.get_closest()
	
	if event is InputEventKey:
		if event.pressed and event.is_action("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
	
