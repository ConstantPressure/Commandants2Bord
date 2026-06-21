extends CanvasModulate

@export var start_color: Color

var color_scale = 1

func _ready() -> void:
	var end_color = color
	self.color = start_color
	var tween = get_tree().create_tween()
	tween.tween_interval(1)
	tween.tween_method(self.set_my_color, start_color, end_color, 2)

func set_my_color(color):
	self.color = color
