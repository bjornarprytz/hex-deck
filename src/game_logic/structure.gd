class_name Structure
extends Resource

enum Alignment {
	Red,
	Blue,
	Yellow,
	Green,
	Orange,
	Purple
}

@export var alignment: Alignment

## Tuples (q,r) are stored as Vector2i here
@export var cells: Array[Vector2i]

func get_affected_tiles(map: Map, originTile: Tile) -> Array[Tile]:
	var affectedTiles: Array[Tile] = []
	
	for cell in cells:
		var targetCoord = originTile.coordinates.add_vec(cell)
		var tile = map.get_tile(targetCoord)
		
		if (tile != null):
			affectedTiles.push_back(tile)
	
	return affectedTiles

func get_rotated(rotationSteps: int) -> Structure:
	while rotationSteps < 0:
		rotationSteps += 6
	rotationSteps = rotationSteps % 6
	
	var rotatedCells: Array[Vector2i] = []
	
	for cell in cells:
		var q = cell.x
		var r = cell.y
		var s = -q-r
		
		for rot in range(rotationSteps):
			var temp_q = q
			q = -r
			r = -s
			s = -temp_q
		
		rotatedCells.push_back(Vector2i(q, r))
	
	var rotatedStructure = Structure.new()
	rotatedStructure.alignment = alignment
	rotatedStructure.cells = rotatedCells
	
	return rotatedStructure
