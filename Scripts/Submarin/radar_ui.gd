extends MarginContainer

@onready var submarine: CharacterBody2D = $"../../../../.."
@onready var radar: TextureRect = $"Radar"
@onready var player: Sprite2D = radar.get_node("Submarine")

var objects: Dictionary = {}
var r_size: Vector2 = Vector2(342.0, 342.0)
var r_scale: float = 342.0 / 10000
var center = r_size / 2

func add_object(object: Node2D, texture: Texture) -> void:
	var sprite = Sprite2D.new()
	sprite.texture = texture
	sprite.scale = Vector2(0.156, 0.156)
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
			if length * r_scale > r_size.x:
				objects[object].hide()
			else:
				objects[object].show()
				var rotated_offset = offset.rotated(-submarine.rotation)
				objects[object].position = center + rotated_offset * r_scale
			if length > 4089:
				remove_object(object)
		else:
			remove_object(object)
