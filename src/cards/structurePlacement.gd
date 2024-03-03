class_name StructurePlacement
extends Node2D


@onready var hex_spawner = preload("res://map/polygon.tscn")

@export var structure: Structure:
	set(value):
		if value == structure:
			return
			
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

func check_placement(map: Map) -> bool:
	# TODO: Actually check
	return false

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
	var coords = Map.Coordinates.new(q, r)
	var key = coords.get_key()
	
	if cells.has(key):
		return
	
	var new_cell = hex_spawner.instantiate() as RegularPolygon
	new_cell.size = 50.0
	
	cells[key] = new_cell
	
	add_child(new_cell)
	new_cell.position = Map.axial_to_pixel(q, r, new_cell.size)
	new_cell._update_polygon()
	
static func axial_to_pixel(q:int,r:int,tile_size:int) -> Vector2:
	var x :float = tile_size * 3.0/2.0 * q
	var y :float = tile_size * sqrt(3) * (r + q/2.0)
	return Vector2(x, y)
