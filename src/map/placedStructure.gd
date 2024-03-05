class_name PlacedStructure
extends Node2D

@onready var hex_spawner = preload("res://map/polygon.tscn")

@export var structure: Structure:
	set(value):
		if value == structure:
			return
			
		structure = value
		_update_preview.call_deferred()

var originTile : Tile
var cells : Dictionary = {}

func _update_preview():
	if (!is_node_ready()):
		return
	
	for child in get_children():
		child.queue_free()
	
	for coord in structure.cells:
		_add_hex(coord.x, coord.y)
	
func _add_hex(q: int, r: int):	
	var new_cell = hex_spawner.instantiate() as RegularPolygon
	new_cell.size = 50.0
	
	add_child(new_cell)
	new_cell.position = Map.axial_to_pixel(q, r, new_cell.size)
	new_cell.modulate = Utils.alignment_to_color(structure.alignment)
	new_cell._update_polygon()
