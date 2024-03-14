class_name Move
extends Effect

var path: Array[Vector2i] = [Utils.axialForward]

func _init(inputPath: Array[Vector2i]=[Utils.axialForward]) -> void:
	path = inputPath

func resolve(args: EffectArgs):
	var placedStructure = args.placedStructure
	var map = args.gameState.map
	var facing = placedStructure.state.facing
	var rotatedPath = Utils.get_rotated_cells(path, facing)
	
	# Clear current position
	for tile in placedStructure.affectedTiles:
		tile.placedStructure = null
	var currentAffectedTiles = placedStructure.affectedTiles

	# Walk along the path
	for step in rotatedPath:
		# Check the placement
		var originTile = currentAffectedTiles[0]
		var targetCoords = originTile.coordinates.add_vec(step)
		var targetTile = map.get_tile(targetCoords)
		var newAffectedTiles = placedStructure.structure.get_affected_tiles(targetTile)
		var obstructed: bool = false
		for tile in newAffectedTiles:
			if tile.placedStructure != null or tile.type == Tile.TerrainType.Water or tile.type == Tile.TerrainType.Mountain:
				obstructed = true
		if obstructed:
			break

		# Move to the new placement
		currentAffectedTiles = newAffectedTiles
		placedStructure.position = targetTile.position

	placedStructure.affectedTiles = currentAffectedTiles
	for tile in placedStructure.affectedTiles:
		tile.placedStructure = placedStructure

func rules_text() -> String:
	return "Move"
