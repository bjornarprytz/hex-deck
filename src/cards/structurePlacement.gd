class_name StructurePlacement
extends Node2D

signal confirmed(tile: Tile)
signal aborted


var structurePreview: StructureView:
	get:
		return $StructurePreview
@onready var baseStructurePosition : Vector2 = structurePreview.position
	
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
	structurePreview.visible = false
	Events.tileClicked.connect(_try_confirm_placement)
	Events.tileHovered.connect(_preview_structure)

func _unhandled_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton and event.is_pressed()):
		match event.button_index:
			MOUSE_BUTTON_WHEEL_UP:
				_rotate_counterclockwise()
			MOUSE_BUTTON_WHEEL_DOWN:
				_rotate_clockwise()
			MOUSE_BUTTON_RIGHT:
				aborted.emit()

func _physics_process(delta: float) -> void:
	rotation = rotate_toward(rotation, _targetRotation, delta * 10.0)

func _preview_structure(hoveredTile: Tile):
	structurePreview.visible = true
	global_position = hoveredTile.global_position

func _try_confirm_placement(targetTile: Tile):
	if (_check_placement(targetTile)):
		confirmed.emit(targetTile)
	else:
		_shake()

func _check_placement(targetTile: Tile) -> bool:
	var rotatedStructure = structure.get_rotated(rotationSteps)
	var affectedTiles = rotatedStructure.get_affected_tiles(map, targetTile)
	var adjacentTiles = rotatedStructure.get_adjacent_tiles(map, targetTile)
	
	for tile in affectedTiles:
		match tile.type:
			Tile.TerrainType.Mountain:
				Debug.push_message("Cannot place on mountain")
				return false
			Tile.TerrainType.Water:
				Debug.push_message("Cannot place on water")
				return false
	
	if (map.structures.get_child_count() == 0):
		var isBorderPlacement = false
		for tile in affectedTiles:
			if map.get_neighbours(tile).size() < 6:
				isBorderPlacement = true
				break
		if !isBorderPlacement:
			Debug.push_message("First tile must be placed on border")
			return false
	else:
		var tileIsAdjacent = false
		for tile in adjacentTiles:
			if tile.structure != null:
				tileIsAdjacent = true
				break
		if !tileIsAdjacent:
			Debug.push_message("Tile needs to be adjacent to another structure")
			return false
	
	if (affectedTiles.size() < structure.cells.size()):
		Debug.push_message("Part of the structure is outside map")
		return false
	
	for tile in affectedTiles:
		if tile.structure != null:
			Debug.push_message("Tile already contains a structure")
			return false
	
	return structure.alignment.validate_placement(affectedTiles, adjacentTiles)

func _rotate_clockwise():
	rotationSteps += 1
	
func _rotate_counterclockwise():
	rotationSteps -= 1

func _shake():
	create_tween().tween_method(_shake_step, 1.0, 0.0, .4)

func _shake_step(d: float):
	var shakeIntensity = 5.0 * d
	var offset = Vector2(randf_range(-shakeIntensity, shakeIntensity), randf_range(-shakeIntensity, shakeIntensity))
	structurePreview.position = baseStructurePosition + offset
	pass
