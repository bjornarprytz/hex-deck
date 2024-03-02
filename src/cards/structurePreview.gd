class_name StructurePreview
extends Node2D

@onready var hex_spawner = preload("res://map/polygon.tscn")

@export var structure: Structure:
	set(value):
		if value == structure:
			return
			
		structure = value
		_update_preview.call_deferred()

var cells : Dictionary = {}

func _update_preview():
	for child in get_children():
		child.queue_free()
		
	for coord in structure.cells:
		_add_tile(coord.x, coord.y)
	
	var center_position := Vector2.ZERO
	for cell in get_children():
		center_position += cell.position
	
	center_position /= get_child_count()
	
	for cell in get_children():
		cell.position -= center_position
	
func _add_tile(q: int, r: int):
	var coords = Map.Coordinates.new(q, r)
	var key = coords.get_key()
	
	if cells.has(key):
		return
	
	var new_cell = hex_spawner.instantiate() as RegularPolygon
	
	cells[key] = new_cell
	
	add_child(new_cell)
	new_cell.position = axial_to_pixel(q, r, new_cell.size)
	new_cell._update_polygon()
	
static func axial_to_pixel(q:int,r:int,tile_size:int) -> Vector2:
	var x :float = tile_size * 3.0/2.0 * q
	var y :float = tile_size * sqrt(3) * (r + q/2.0)
	return Vector2(x, y)
