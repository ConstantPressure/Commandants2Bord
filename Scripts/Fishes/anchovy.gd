extends RigidBody2D

@onready var submarine: CharacterBody2D = $"../Submarin"
@onready var wait: Timer = $"Wandering"
@onready var atk_spd: Timer = $"AttackSpeed"
@onready var recoil_wait: Timer = $"RecoilWait"

var player_in_vision: bool = false
var player_in_range: bool = false
var velocity: Vector2 = Vector2.ZERO
var raw_velocity: Vector2 = Vector2.ZERO
var target_position: Vector2 = Vector2.ZERO

enum { IDLE, WANDER, FOLLOW, ATK, RUSH, RECOIL, RECOIL_WAIT }
var state = IDLE

const SPEED: float = 100.0
const TOLERANCE: float = 4.0
const KNOCKBACK_FORCE: float = 150.0
const LERP_WEIGHT: float = 0.12

func _ready() -> void:
	target_position = global_position

func update_target_position():
	var target_vector = Vector2(randf_range(-200, 200), randf_range(-200, 200))
	target_position = global_position + target_vector

func is_at_target_position():
	return (target_position - global_position).length() < TOLERANCE

func chek_hit_submarine(collide: KinematicCollision2D) -> void:
	if collide:
		var object: Object = collide.get_collider()
		if object.has_method("hit"):
			object.hit(raw_velocity)
			var recoil_dir = global_position.direction_to(submarine.global_position) * -1
			raw_velocity = recoil_dir * KNOCKBACK_FORCE
			velocity = raw_velocity * get_physics_process_delta_time()
			state = RECOIL

func _physics_process(delta: float) -> void:
	match state:
		WANDER:
			var desired = global_position.direction_to(target_position) * (SPEED * 0.7) * delta
			velocity = velocity.lerp(desired, LERP_WEIGHT)
			if is_at_target_position():
				state = IDLE
		FOLLOW:
			var desired = global_position.direction_to(submarine.global_position) * SPEED * delta
			velocity = velocity.lerp(desired, LERP_WEIGHT)
		IDLE:
			velocity = velocity.lerp(Vector2.ZERO, LERP_WEIGHT)
			if wait.is_stopped():
				wait.wait_time = randi_range(2, 10)
				wait.start()
		ATK:
			velocity = velocity.lerp(Vector2.ZERO, LERP_WEIGHT)
			if atk_spd.is_stopped():
				atk_spd.start()
		RUSH:
			velocity = velocity.lerp(Vector2.ZERO, 0.01)
		RECOIL:
			velocity = velocity.lerp(Vector2.ZERO, LERP_WEIGHT * 0.6)
			if velocity.length() < 2.0:
				velocity = Vector2.ZERO
				state = RECOIL_WAIT
				recoil_wait.start()
		RECOIL_WAIT:
			velocity = Vector2.ZERO
	var collide = move_and_collide(velocity)
	chek_hit_submarine(collide)
	look_at(velocity)
	if velocity.length() > 1.0:
		var target_angle = velocity.angle()
		rotation = lerp_angle(rotation, target_angle, 0.15)
		if rotation_degrees < 0 and scale.y > 0:
			scale.y *= -1
		elif rotation_degrees > 0 and scale.y < 0:
			scale.y *= -1

func _process(delta: float) -> void:
	if state == RECOIL or state == RECOIL_WAIT or state == ATK:
		return
	if player_in_vision and not submarine.is_ligth_on:
		state = IDLE
	elif player_in_vision and submarine.is_ligth_on:
		state = FOLLOW

func _on_detect_body_entered(body: Node2D) -> void:
	if body.is_in_group("submarine"):
		player_in_vision = true

func _on_detect_body_exited(body: Node2D) -> void:
	if body.is_in_group("submarine"):
		player_in_vision = false
		player_in_range = false
		if state != RECOIL:
			state = IDLE

func _on_attack_body_entered(body: Node2D) -> void:
	if body.is_in_group("submarine"):
		player_in_range = true
		if state != RECOIL and state != RECOIL_WAIT:
			state = ATK
			velocity = Vector2.ZERO

func _on_attack_body_exited(body: Node2D) -> void:
	if body.is_in_group("submarine"):
		player_in_range = false
		if state != RECOIL:
			state = FOLLOW

func _on_wandering_timeout() -> void:
	state = WANDER
	update_target_position()

func _on_attack_speed_timeout() -> void:
	if state == ATK:
		raw_velocity = global_position.direction_to(submarine.global_position) * SPEED * 1.6
		velocity = raw_velocity * get_physics_process_delta_time()
		state = RUSH

func _on_recoil_wait_timeout() -> void:
	if player_in_range:
		state = ATK
	elif player_in_vision:
		state = FOLLOW
	else:
		state = IDLE
