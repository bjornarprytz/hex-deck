class_name EachConnectedTile
extends Effect

var tilePileEffect: TilePileEffect

func _init(inputTilePileEffect: TilePileEffect):
	tilePileEffect = inputTilePileEffect

func resolve(args: PlacementEffectArgs):
	var myAlignment = args.placedStructure.structure.alignment

	var connectedTiles: Array[Tile] = []
	connectedTiles.append_array(args.placedStructure.affectedTiles)

	var queue: Array[Tile] = []
	queue.append_array(args.placedStructure.affectedTiles)

	while queue.size() > 0:
		var currentTile = queue.pop_front()
		for tile in currentTile.get_neighbours():
			if !connectedTiles.has(tile) and tile.has_structure() and tile.placedStructure.structure.alignment == myAlignment:
				var tiles = tile.placedStructure.affectedTiles
				connectedTiles.append_array(tiles)
				queue.append_array(tiles)

	await tilePileEffect.resolve(TilePileEffectArgs.new(args.gameState, connectedTiles))

func rules_text() -> String:
	return "Resolve an effect per connected tile."

func keyword() -> String:
	return "Connected: %s" % tilePileEffect.keyword()
