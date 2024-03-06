class_name StructurePlacement
extends Node2D

signal confirmed(tile: Tile)
signal aborted


var structurePreview: StructureView:
	get:
		return $StructurePreview

var structure: Structure:
	set(value):
		structurePreview.structure = value
	get:
		return structurePreview.structure

var map : Map:
	set(value):
		map = value

var _targetRotation : float

var rotationSteps: int:
	set(value):
		while value < 0:
			value += 6
		value = value % 6
		if (value == rotationSteps):
			return
		
		rotationSteps = value
		_targetRotation = (PI/3.0) * rotationSteps

func _ready() -> void:
	Events.tileClicked.connect(_try_confirm_placement)
	Events.tileHovered.connect(_preview_structure)

func _unhandled_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton and event.is_pressed()):
		match event.button_index:
			MOUSE_BUTTON_WHEEL_UP:
				_rotate_clockwise()
			MOUSE_BUTTON_WHEEL_DOWN:
				_rotate_counterclockwise()
			MOUSE_BUTTON_RIGHT:
				aborted.emit()

func _physics_process(delta: float) -> void:
	rotation = rotate_toward(rotation, _targetRotation, delta * 10.0)

func _preview_structure(hoveredTile: Tile):

	global_position = hoveredTile.global_position
	_check_placement(hoveredTile)

func _try_confirm_placement(targetTile: Tile):
	# TODO: Add Validation
	if (_check_placement(targetTile)):
		confirmed.emit(targetTile)

func _check_placement(originTile: Tile) -> bool:
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

func _rotate_clockwise():
	rotationSteps += 1
	
func _rotate_counterclockwise():
	rotationSteps -= 1



