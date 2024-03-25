class_name Structure
extends Resource

var alignment: Alignment.Id:
	set(value):
		if (alignment == value):
			return
		var oldAlignment = alignment
		alignment = value
		
		onAlignmentChanged.emit(oldAlignment, alignment)
var specialRules: RulesHooks
## Tuples (q,r) are stored as Vector2i here
var cells: Array[Vector2i]

signal onAlignmentChanged(oldAlignment: Alignment.Id, newAlignment: Alignment.Id)

func _init(inputAlignment: Alignment.Id, inputCells: Array[Vector2i], rulesHooks: RulesHooks):
	alignment = inputAlignment
	cells = inputCells
	specialRules = rulesHooks

func get_color() -> Color:
	return Meta.alignmentRules[alignment].get_color()

func get_rules() -> RulesHooks:
	return Meta.alignmentRules[alignment].get_rules().merge(specialRules)

func get_adjacent_tiles(originTile: Tile) -> Array[Tile]:
	var map = originTile.map
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

func get_affected_tiles(originTile: Tile) -> Array[Tile]:
	var map = originTile.map
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
	
	var rotatedCells = Utils.get_rotated_cells(cells, rotationSteps)
	
	return Structure.new(alignment, rotatedCells, specialRules)
