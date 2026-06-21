extends MarginContainer

@onready var submarine: CharacterBody2D = $"../../../../.."
@onready var radar: TextureRect = $"Radar"
@onready var player: Sprite2D = radar.get_node("Submarine")
@onready var aimer: Node2D = $"../../.."

var objects: Dictionary = {}
var half_cone: float = 0.2
var r_size: Vector2 = Vector2(342.0, 342.0)
var r_scale: float = 342.0 / 10000
var center = r_size / 2

func add_object(object: Node2D, texture: Texture) -> void:
	var sprite = Sprite2D.new()
	sprite.texture = texture
	objects[object] = sprite
	radar.add_child(sprite)

func remove_object(object: Node2D) -> void:
	if objects.has(object):
		objects[object].queue_free()
		objects.erase(object)

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	player.rotation_degrees = submarine.rotation_degrees
	player.position = center

	for object in objects.keys():
		if is_instance_valid(object):
			var offset: Vector2 = object.position - submarine.position
			var length: float = offset.length()
			if length > 5000:
				remove_object(object)
				continue
			var in_cone := true
			if aimer != null:
				var aimer_world_angle: float = submarine.rotation + aimer.rotation - deg_to_rad(27.5)
				var to_object_angle: float = offset.angle()
				var diff: float = angle_difference(to_object_angle, aimer_world_angle)
				in_cone = abs(diff) <= half_cone
			if length * r_scale > r_size.x or not in_cone:
				objects[object].hide()
			else:
				objects[object].show()
				var rotated_offset = offset.rotated(-submarine.rotation)
				objects[object].position = center + rotated_offset * r_scale
		else:
			remove_object(object)
