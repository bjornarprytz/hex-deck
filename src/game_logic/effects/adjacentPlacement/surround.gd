class_name Surround
extends Effect

var tileCount: int
var effect: TilePileEffect

func _init(inputTileCount: int, triggerEffect: TilePileEffect):
	tileCount = inputTileCount
	effect = triggerEffect

func resolve(args: AdjacentPlacementEffectArgs):
	var adjacentTiles = args.adjacentStructure.get_adjacent_tiles()

	var coveredTiles: Array[Tile] = []

	for adjacentTile in adjacentTiles:
		if adjacentTile.has_structure():
			coveredTiles.push_back(adjacentTile)
	
	if coveredTiles.size() >= tileCount:
		await effect.resolve(TilePileEffectArgs.new(args.gameState, coveredTiles))

func rules_text() -> String:
	return "Envelop structure with %d tiles" % tileCount

func keyword() -> String:
	return "Envelop %d" % tileCount
