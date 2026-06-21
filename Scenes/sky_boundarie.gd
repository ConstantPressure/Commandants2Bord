extends StaticBody2D

func _process(delta: float) -> void:
	var item_count = get_tree().get_node_count_in_group("items")
	
	if item_count == 3:
		position.y = -2000
	if item_count == 2:
		position.y = -2750
	if item_count == 1:
		position.y = -3500
		$"../Background/Sea/Sprite2D".scale.y = 2
	if item_count == 0:
		position.y = -5000
		$"../Background/Sea/Sprite2D".scale.y = 3
