@tool
class_name RegularPolygon
extends Polygon2D

@export var size: float = 25.0:
	get:
		return size
	set(value):
		if value == size:
			return
		if value < 0.0:
			value = 1.0
		
		size = value
		_update_polygon.call_deferred()

@export var n_sides: int = 6:
	get:
		return n_sides
	set(value):
		if value == n_sides:
			return
		
		if (value < 3):
			value = 3
		
		n_sides = value
		_update_polygon.call_deferred()

@export var border_color: Color:
	set(value):
		if (border_color == value):
			return
		border_color = value
		_update_polygon.call_deferred()
		
@export var border_width: float:
	set(value):
		if (border_width == value):
			return
		border_width = value
		_update_polygon.call_deferred()

@onready var border : Line2D = $Border

func _update_polygon():
	if !is_node_ready():
		return
		
	border.width = border_width
	border.default_color = border_color

	var angle_increment = 2 * PI / n_sides

	var points: PackedVector2Array = []
	for i in range(n_sides):
		var angle = i * angle_increment
		var x = size * cos(angle)
		var y = size * sin(angle)
		
		points.push_back(Vector2(x, y))
	
	polygon = points
	border.points = points
	
	queue_redraw()
