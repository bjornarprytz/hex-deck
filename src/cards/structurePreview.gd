@tool
class_name StructurePreview
extends Node2D

@onready var hex_spawner = preload("res://map/polygon.tscn")

@export var structure: Structure:
	set(value):
		structure = value
		_update_preview.call_deferred()

func _update_preview():
	for child in get_children():
		child.queue_free()
		
	for coord in structure.cells:
		_add_hex(coord.x, coord.y)
	
	var center_position := Vector2.ZERO
	for cell in get_children():
		center_position += cell.position
	
	center_position /= get_child_count()
	
	for cell in get_children():
		cell.position -= center_position
	
func _add_hex(q: int, r: int):
	var new_cell = hex_spawner.instantiate() as RegularPolygon
	
	new_cell.position = Map.axial_to_pixel(q, r, new_cell.size)
	new_cell.color = Utils.alignment_to_color(structure.alignment)
	add_child(new_cell)
