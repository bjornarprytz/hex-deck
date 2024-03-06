class_name StructurePlacement
extends Node2D


var structurePreview: StructureView:
	get:
		return $StructurePreview


@export var structure: Structure:
	set(value):
		structurePreview.structure = value
	get:
		return structurePreview.structure

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

