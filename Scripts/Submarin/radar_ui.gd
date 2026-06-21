extends MarginContainer

@onready var submarine: CharacterBody2D = $"../../../../.."
@onready var radar: TextureRect = $"Radar"
@onready var player: Sprite2D = radar.get_node("Submarine")

var objects: Dictionary = {}
var r_size: Vector2 = Vector2(80.0, 80.0)
var r_scale: float = 80.0 / 1100.0

func add_object(object: Node2D, texture: Texture) -> void:
	var sprite = Sprite2D.new()
	sprite.texture = texture
	sprite.scale = Vector2(0.156, 0.156)
	objects[object] = sprite
	radar.add_child(sprite)

func remove_object(object: Node2D) -> void:
	objects[object].queue_free()
	objects.erase(object)

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	player.rotation_degrees = submarine.rotation_degrees
	for object in objects.keys():
		if is_instance_valid(object):
			var length: float = (object.postion - submarine.position).length()
			if length * r_scale > r_size.x:
				objects[object].hide()
			else:
				objects[object].show()
			if length > 4089:
				remove_object(object)
		else:
			remove_object(object)
