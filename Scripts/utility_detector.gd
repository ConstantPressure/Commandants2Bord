extends Area2D

var utility_list: Array[Node2D] = []

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("utility"):
		utility_list.append(area)

func _on_area_exited(area: Area2D) -> void:
	if area in utility_list:
		utility_list.erase(area)

func get_closest():
	if utility_list.is_empty():
		return null
	
	var closest = utility_list[0]
	var closest_dist = global_position.distance_to(utility_list[0].global_position)
	for obj in utility_list:
		if global_position.distance_to(obj.global_position) < closest_dist:
			closest = obj
			closest_dist = global_position.distance_to(obj.global_position)
	
	return closest
