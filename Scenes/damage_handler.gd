extends Node

@onready var boundaries = $"../Boundaries/InsideBackground"
@export var hole_scene: PackedScene

func generate_hole():
	var hole = hole_scene.instantiate()
	hole.position = random_point_in_polygon(boundaries.polygon)
	hole.scale *= 0.4
	get_parent().add_child(hole)

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
