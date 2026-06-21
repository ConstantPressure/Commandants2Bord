extends Area2D

var interractable_list: Array[Node2D] = []

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("interractable"):
		interractable_list.append(area)

func _on_area_exited(area: Area2D) -> void:
	if area in interractable_list:
		interractable_list.erase(area)

func get_closest():
	if interractable_list.is_empty():
		return null
	
	var closest = interractable_list[0]
	var closest_dist = global_position.distance_to(interractable_list[0].global_position)
	for obj in interractable_list:
		if global_position.distance_to(obj.global_position) < closest_dist:
			closest = obj
			closest_dist = global_position.distance_to(obj.global_position)
	
	return closest
