class_name StructurePlacement
extends Node2D


@onready var hex_spawner = preload("res://map/polygon.tscn")

@export var structure: Structure:
	set(value):
		structure = value
		_update_preview.call_deferred()

var _targetRotation : float

var cells : Dictionary = {}
var rotationSteps: int:
	set(value):
		while value < 0:
			value += 6
		value = value % 6
		if (value == rotationSteps):
			return
		
		rotationSteps = value
		_targetRotation = (PI/3.0) * rotationSteps

func check_placement(map: Map, originTile: Tile) -> bool:
	var rotatedStructure = structure.get_rotated(rotationSteps)
	var affectedTiles = rotatedStructure.get_affected_tiles(map, originTile)
	
	if (affectedTiles.size() < structure.cells.size()):
		print("Part of the structure is outside map")
		return false
	
	for tile in affectedTiles:
		if tile.structure != null:
			print("Tile already contains a structure")
			return false
	
	return true

func rotate_clockwise():
	rotationSteps += 1
	
func rotate_counterclockwise():
	rotationSteps -= 1

func _physics_process(delta: float) -> void:
	rotation = rotate_toward(rotation, _targetRotation, delta * 10.0)

func _update_preview():
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

