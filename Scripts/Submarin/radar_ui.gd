extends MarginContainer

@onready var submarine: CharacterBody2D = $"../../../../.."
@onready var radar: TextureRect = $"Radar"
@onready var player: Sprite2D = radar.get_node("Submarine")
@onready var aimer: Node2D = $"../../.."

var blip_checkpoint = preload("res://Assets/Submarine/blip_red.png")
var blip_item = preload("res://Assets/Submarine/blip_yellow.png")

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
	for body in get_tree().root.get_node("Main").get_children():
		if body.is_in_group("checkpoint"):
			add_object(body, blip_checkpoint)
		if body.is_in_group("items"):
			add_object(body, blip_item)

func _physics_process(delta: float) -> void:
	player.position = center
	
	for object in objects.keys():
		if is_instance_valid(object):
			var offset: Vector2 = object.position - submarine.position
			var length: float = offset.length()
			var sprite: Sprite2D = objects[object]
			var always_visible: bool = (sprite.texture == blip_checkpoint or sprite.texture == blip_item)
			var in_cone := true
			if aimer != null:
				var aimer_world_angle: float = submarine.rotation + aimer.rotation - deg_to_rad(27.5)
				var to_object_angle: float = offset.angle()
				var diff: float = angle_difference(to_object_angle, aimer_world_angle)
				in_cone = abs(diff) <= half_cone
			var rotated_offset = offset #offset.rotated(-submarine.rotation)
			var radar_pos: Vector2 = rotated_offset * r_scale
			var radar_dist: float = radar_pos.length()
			var max_radar_radius: float = r_size.x / 2
			if always_visible:
				if radar_dist > max_radar_radius:
					radar_pos = radar_pos.normalized() * (max_radar_radius - 8)
				sprite.position = center + radar_pos
				sprite.show()
			else:
				if length * r_scale > r_size.x or not in_cone:
					sprite.hide()
				else:
					sprite.show()
					sprite.position = center + radar_pos
		else:
			remove_object(object)
