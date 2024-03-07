class_name Structure
extends Resource

@export var alignment: Alignment

## Tuples (q,r) are stored as Vector2i here
@export var cells: Array[Vector2i]

func get_adjacent_tiles(map: Map, originTile: Tile) -> Array[Tile]:
	var adjacent_tiles: Array[Tile] = []
	var adjacent_cells: Array[Vector2i] = []
	
	for cell in cells:
		for neighbor in Utils.get_axial_neighbors(cell):
			if !adjacent_cells.has(neighbor) and !cells.has(neighbor):
				adjacent_cells.push_back(neighbor)
		
	for cell in adjacent_cells:
		var targetCoord = originTile.coordinates.add_vec(cell)
		var tile = map.get_tile(targetCoord)
		if (tile != null):
			adjacent_tiles.push_back(tile)
	
	return adjacent_tiles

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
