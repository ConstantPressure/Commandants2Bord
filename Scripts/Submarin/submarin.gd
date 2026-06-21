extends CharacterBody2D
@onready var water_shader: Polygon2D = $Boundaries/InsideBackground/Polygon2D
@onready var outside_sound: AudioStreamPlayer2D = $OutsideSound
@onready var inside_sound: AudioStreamPlayer2D = $InsideSound
@onready var hit_sounds: Array[AudioStreamPlayer2D] = [$HitSound1, $HitSound2, $HitSound3]
@onready var game_over: Timer = $GameOver
@onready var game_over_sound: AudioStreamPlayer2D = $GameOverSound
@onready var game_over_explosion: Sprite2D = $GameOverExplosion

var direction: Vector2 = Vector2(1.0, 0.0)
var speed: float = 0.0

var health: float = 100
var explosion_game_over_scale: float = 0.0

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
	knockback += vel.normalized() * SUBMARINE_KNOCKBACK * (impact_speed / 100.0)
	$DamageHandler.generate_hole()
	hit_sounds[randi_range(0, 2)].play()

func _physics_process(_delta: float) -> void:
	var motor_velocity = (Vector2.RIGHT * speed).rotated(rotation)
	velocity = motor_velocity + knockback
	knockback = knockback.lerp(Vector2.ZERO, KNOCKBACK_DECAY)
	var water_level = lerp(0.697, 0.659, health / 100.0)
	water_shader.material.set("shader_parameter/liquid_level", water_level)
	move_and_slide()

func _process(delta: float) -> void:
	var submarin_speed: float = (velocity.x + velocity.y) * 0.05
	if submarin_speed < 0:
		submarin_speed *= -1
	outside_sound.volume_db = -25 + submarin_speed
	if not is_ligth_on:
		inside_sound.volume_db = -50
	else:
		inside_sound.volume_db = -30
	if health <= 0: 
		if game_over.is_stopped():
			game_over.start()
			game_over_sound.play()
		explosion_game_over_scale = lerp(explosion_game_over_scale, 1.0, 1 * delta)
		game_over_explosion.modulate = Color(1, 1, 1, explosion_game_over_scale)

func _on_game_over_timeout() -> void:
	get_tree().quit()
