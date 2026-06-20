extends CharacterBody2D

var direction: Vector2 = Vector2(1.0, 0.0)
var speed: float = 0.0

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	velocity = (Vector2.RIGHT * speed).rotated(rotation)
	move_and_slide()

func _process(_delta: float) -> void:
	pass
