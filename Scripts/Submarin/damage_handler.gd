extends Node

@onready var boundaries = $"../Boundaries/InsideBackground"
@onready var submarin = get_parent()
@export var hole_scene: PackedScene

var HOLE_DPS := 1

func _process(delta: float) -> void:
	submarin.health = max(0, submarin.health - get_tree().get_node_count_in_group("hole") * HOLE_DPS * delta)

func generate_hole():
	var hole = hole_scene.instantiate()
	hole.position = random_point_in_polygon(boundaries.polygon)
	hole.scale *= 0.4
	add_child(hole)
	
func random_point_in_polygon(polygon: PackedVector2Array) -> Vector2:
	var rect := Rect2(polygon[0], Vector2.ZERO)

	for p in polygon:
		rect = rect.expand(p)

	while true:
		var point = Vector2(
			randf_range(rect.position.x, rect.end.x),
			randf_range(rect.position.y, rect.end.y)
		)

		if Geometry2D.is_point_in_polygon(point, polygon):
			return point
	
	return Vector2.ZERO
