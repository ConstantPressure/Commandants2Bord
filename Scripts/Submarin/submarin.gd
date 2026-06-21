extends CharacterBody2D

var direction: Vector2 = Vector2(1.0, 0.0)
var speed: float = 0.0

var health: float = 100
var is_ligth_on: bool = true
var knockback: Vector2 = Vector2.ZERO

const MIN_IMPACT_SPEED: float = 10.0
const DAMAGE_MULTIPLIER: float = 0.1
const SUBMARINE_KNOCKBACK: float = 250.0
const KNOCKBACK_DECAY: float = 0.08

func _ready() -> void:
	pass

func hit(vel: Vector2) -> void:
	var impact_speed = vel.length()
	if impact_speed < MIN_IMPACT_SPEED:
		return
	var damage = impact_speed * DAMAGE_MULTIPLIER
	health -= damage
	knockback += vel.normalized() * SUBMARINE_KNOCKBACK * (impact_speed / 100.0)
	print(health)

func _physics_process(_delta: float) -> void:
	var motor_velocity = (Vector2.RIGHT * speed).rotated(rotation)
	velocity = motor_velocity + knockback
	knockback = knockback.lerp(Vector2.ZERO, KNOCKBACK_DECAY)
	move_and_slide()

func _process(_delta: float) -> void:
	if health < 0:
		pass
