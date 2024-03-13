@tool
class_name StructureView
extends Node2D

@onready var hex_spawner = preload ("res://map/polygon.tscn")

@export var structure: Structure:
	set(value):
		if (structure == value):
			return
		structure = value
		if is_node_ready():
			_update_preview.call_deferred()

@export var centerPreview: bool:
	set(value):
		if (centerPreview == value):
			return
		centerPreview = value
		if is_node_ready():
			_update_preview.call_deferred()

@export var hexSize: float = 50:
	set(value):
		if (hexSize == value):
			return
		hexSize = value
		if is_node_ready():
			_update_preview.call_deferred()

@export var borderWidth: float = 0.0:
	set(value):
		if (borderWidth == value):
			return
		borderWidth = value
		if is_node_ready():
			_update_preview.call_deferred()

func get_cells() -> Array[RegularPolygon]:
	var cells: Array[RegularPolygon] = []
	
	for child in get_children():
		cells.push_back(child)
	
	return cells

func _ready() -> void:
	_update_preview()

func _update_preview():
	for child in get_children():
		child.queue_free()
		
	for coord in structure.cells:
		_add_hex(coord.x, coord.y)
	
	var centroid := Vector2.ZERO
	
	if (centerPreview):
		for cell in get_children():
			centroid += cell.position
		
		centroid /= get_child_count()
		
		for cell in get_children():
			cell.position -= centroid
	
	if (borderWidth > 0):
		var edges: Dictionary = {}
		for cell in structure.cells:
			var cellPoints = Utils.get_polygon_points(cell, 6, hexSize)
			for n in Utils.get_axial_neighbors(cell):
				var sharedPoints: Array[Vector2] = []
				var neigbourPoints = Utils.get_polygon_points(n, 6, hexSize)
				for cellPoint in cellPoints:
					for nPoint in neigbourPoints:
						if cellPoint.distance_to(nPoint) < (hexSize / 2.0): # Coarse comparision, but close enough
							sharedPoints.push_back(cellPoint)
				var keys = [str(cell), str(n)]
				keys.sort()
				var key = "%s%s" % keys
				if edges.has(key):
					edges.erase(key)
				else:
					edges[key] = sharedPoints
		for edge in edges.values():
			var line = Line2D.new()
			line.position -= centroid
			line.add_point(edge[0])
			line.add_point(edge[1])
			line.width = borderWidth
			line.default_color = Color.DIM_GRAY
			add_child(line)
			line.queue_redraw()
	
func _add_hex(q: int, r: int):
	var new_cell = hex_spawner.instantiate() as RegularPolygon
	new_cell.size = hexSize
	new_cell.position = Utils.axial_to_pixel(q, r, new_cell.size)
	new_cell.color = structure.alignment.get_color()
	add_child(new_cell)
