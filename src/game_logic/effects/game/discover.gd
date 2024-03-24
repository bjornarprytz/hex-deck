class_name DiscoverTile
extends Effect

func resolve(args: EffectArgs):
	var map = args.gameState.map
	var newTileCoords = map.undiscoveredTiles.values().pick_random()
	var newTile = map.discover_tile(newTileCoords)
	
	Events.onDiscoverTile.emit(args, [newTile])

func rules_text() -> String:
	return "DiscoverTile a tile"

func keyword() -> String:
	return "Discover"
