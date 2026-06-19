extends CharacterBody2D

var direction: Vector2 = Vector2(-1.0, 0.0)
var speed: float = 0.0

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta

func _process(delta: float) -> void:
	pass
