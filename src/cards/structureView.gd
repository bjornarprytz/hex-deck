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

@export var hex_size: float = 50:
	set(value):
		if (hex_size == value):
			return
		hex_size = value
		if is_node_ready():
			_update_preview.call_deferred()

func get_cells() -> Array[RegularPolygon]:
	var cells : Array[RegularPolygon] = []
	
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
	
	if (!centerPreview):
		return
	
	var centroid := Vector2.ZERO
	for cell in get_children():
		centroid += cell.position
	
	centroid /= get_child_count()
	
	for cell in get_children():
		cell.position -= centroid
	
func _add_hex(q: int, r: int):
	var new_cell = hex_spawner.instantiate() as RegularPolygon
	new_cell.size = hex_size
	new_cell.position = Map.axial_to_pixel(q, r, new_cell.size)
	new_cell.color = structure.alignment.get_color()
	add_child(new_cell)
